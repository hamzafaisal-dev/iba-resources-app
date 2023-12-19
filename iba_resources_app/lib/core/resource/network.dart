import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:path/path.dart';

class ResourceFirestoreClient {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  ResourceFirestoreClient({
    required this.firestore,
    required this.firebaseStorage,
  });

  Future<List<ResourceModel>> getAllResources() async {
    // fetches all documents in the resources collection
    final resources =
        await firestore.collection('resources').orderBy('createdAt').get();

    // resources.docs returns a list of QueryDocumentSnapshot
    // maps over the list, converts each document into a Resource, returns list of Resources
    List<ResourceModel> allFetchedResources = resources.docs.map((docSnapshot) {
      return ResourceModel.fromJson(docSnapshot.data());
    }).toList();

    return allFetchedResources;
  }

  Future<List<ResourceModel>> getSearchedResources(String searchedName) async {
    // fetches all documents in the resources collection
    final resources = await firestore
        .collection('resources')
        .where('resourceTitle', isGreaterThanOrEqualTo: searchedName)
        .where('resourceTitle', isLessThanOrEqualTo: '$searchedName\uf8ff')
        .get();

    // resources.docs returns a list of QueryDocumentSnapshot
    // maps over the list, converts each document into a Resource, returns list of Resources
    List<ResourceModel> allFetchedResources = resources.docs.map((docSnapshot) {
      return ResourceModel.fromJson(docSnapshot.data());
    }).toList();

    return allFetchedResources;
  }

  Future<void> downloadResource(List<dynamic> fileDownloadUrls) async {
    // takes in list of download URLs, loops over the list, downloads each file onto phone
    for (String fileUrl in fileDownloadUrls) {
      await FileDownloader.downloadFile(
        url: fileUrl,
        onDownloadCompleted: (path) {
          // final File file = File(path);
          print('Download successful!');
        },
        onProgress: (fileName, progress) {
          print(progress);
        },
      );
    }
  }

  Future<void> bookmarkResource(
    ResourceModel savedResource,
    UserModel user,
    bool isBookMarked,
  ) async {
    late UserModel updatedUser;
    List<ResourceModel>? usersSavedResources = user.savedResources ?? [];

    // have to toggle isBookMarked bec previous value is being passed in, lazy state or something
    isBookMarked = !isBookMarked;

    print('resource in resource network: $savedResource');

    if (isBookMarked) {
      // add savedResource to the list if not already present
      if (!usersSavedResources.contains(savedResource)) {
        usersSavedResources.add(savedResource);
      }
    } else {
      // remove savedResource from the list
      usersSavedResources.remove(savedResource);
    }

    // update the user model with the modified savedResources list
    updatedUser = user.copyWith(savedResources: usersSavedResources);

    // update the user document in Firestore
    await firestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());
  }

  Future<FilePickerResult?> selectFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) throw Exception('No files selected');

    return result;
  }

  // returns the download URL of given file
  Future<String> uploadToFirebaseStorage(
      File file, String resourceTitle) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // get file name
    String fileName = basename(file.path);

    // put file in documents collection, files stored in a folder whose name is given by user, individual filenames will be their own names+currentTimeStamp to avoid duplicity
    final storageRef = firebaseStorage
        .ref()
        .child('documents')
        .child(resourceTitle)
        .child('$fileName-$currentTimeStamp');

    await storageRef.putFile(file);

    String fileUrl = await storageRef.getDownloadURL();

    return fileUrl;
  }

  Future<void> uploadResource(
    FilePickerResult pickedFiles,
    String resourceTitle,
    String resourceDescription,
    String resourceType,
    String teacherName,
    String courseName,
    List<String> relevantFields,
    String semester,
    String year,
  ) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    List<String> fileUrls = [];

    // maps over each file path and converts to a File object, then converts to list
    List<File> files = pickedFiles.paths.map((path) => File(path!)).toList();

    // uploads each file to FB storage, gets individual download URL and adds URL to fileURLS list
    for (File file in files) {
      String fileUrl = await uploadToFirebaseStorage(file, resourceTitle);

      fileUrls.add(fileUrl);
    }

    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();

    if (!userSnapshot.exists) throw Exception('User does not exist');

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    String username = userData['name'];

    ResourceModel newResource = ResourceModel(
      resourceId: '$resourceTitle-$timeStamp',
      resourceTitle: resourceTitle,
      resourceFiles: fileUrls,
      resourceDescription: resourceDescription,
      resourceType: resourceType,
      uploader: username,
      courseName: courseName,
      teacherName: teacherName,
      relevantFields: relevantFields,
      semester: semester,
      year: year,
      likes: 0,
      dislikes: 0,
      reportCount: 0,
      createdAt: DateTime.now(),
      updatedAt: null,
      isActive: true,
      isDeleted: false,
    );

    await FirebaseFirestore.instance
        .collection('resources')
        .doc('$resourceTitle-$timeStamp')
        .set(newResource.toMap());
  }
}
