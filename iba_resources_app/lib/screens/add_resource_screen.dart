import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:iba_resources_app/widgets/image_input.dart';
import 'package:path/path.dart';

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  final _resourceNameController = TextEditingController();
  final _resourceDescriptionController = TextEditingController();
  final _teacherNameController = TextEditingController();
  final _semesterController = TextEditingController();
  final _yearController = TextEditingController();

  File? _selectedImage;

  late FilePickerResult pickedFiles;

  String getFileExtension(String filePath) {
    return extension(filePath).toLowerCase();
  }

  void addResource() async {
    // get extension of selected file
    String fileExtension = getFileExtension(_selectedImage!.path);

    // 1. ref gives reference to Firebase cloud storage bucket
    // 2. child creates new path in storage bucket
    // 3. 'user_images' is a new folder where you will store your images. folder name is upto us
    // 4. we gave a custom name to the file based on user's uid
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('documents')
        .child('booty-shake$fileExtension');

    // put selected image in the folder we created and it's name will be the one we specified
    await storageRef.putFile(_selectedImage!);

    // gives URL to image
    final imageUrl = await storageRef.getDownloadURL();

    print(imageUrl);

    // await FileDownloader.downloadFile(
    //   url: imageUrl,
    //   onDownloadCompleted: (path) {
    //     final File file = File(path);
    //   },
    // );

    // // 1. create instance of Firestore and create new collection in it called users
    // // 2. then we create a new document in it and it's name is our user's uid
    // // 3. then we set new data in that document
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('new-image.jpg')
    //     .set({
    //   'userName': _enteredUsername,
    //   'email': _enteredEmail,
    //   'image_url': imageUrl
    // });
  }

  // returns the download URL of given file
  Future<String> _uploadToFirebaseStorage(File file) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // get file name
    String fileName = basename(file.path);

    // put file in documents collection, files stored in a folder whose name is given by user, individual files will have their own names+currentTimeStamp to avoid duplicity
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('documents')
        .child(_resourceNameController.text)
        .child('$fileName-$currentTimeStamp');

    await storageRef.putFile(file);

    String fileUrl = await storageRef.getDownloadURL();

    return fileUrl;
  }

  Future<FilePickerResult?> _selectFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return null;

    pickedFiles = result;

    return pickedFiles;
  }

  void _uploadResource() async {
    print(_resourceNameController.text);
    print(_resourceDescriptionController.text);
    print(_teacherNameController.text);
    print(_semesterController.text);
    print(_yearController.text);

    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    List<String> fileUrls = [];

    // maps over each file path and converts to a File object, then converts to list
    List<File> files = pickedFiles.paths.map((path) => File(path!)).toList();

    // uploads each file to FB storage, gets individual download URL and adds URL to fileURLS list
    for (File file in files) {
      String fileUrl = await _uploadToFirebaseStorage(file);

      fileUrls.add(fileUrl);
    }

    await FirebaseFirestore.instance
        .collection('resources')
        .doc('${_resourceNameController.text}-$timeStamp')
        .set({
      'resourceTitle': _resourceNameController.text,
      'resourceFiles': fileUrls,
      'uploader': 'Farhan Mushi', //FirebaseAuth.instance.currentUser,
      'teacherName': _teacherNameController.text,
      'relevantFields': [],
      'semester': _semesterController.text,
      'year': _yearController.text,
      'isActive': true,
      'isDeleted': false,
      'createdAt': DateTime.now(),
      'updatedAt': null,
    });

    print(fileUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          //
          const SizedBox(height: 20),

          Text(
            'Select A Resource',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: _selectFiles,
            child: const Icon(Icons.library_add_rounded),
          ),

          const SizedBox(height: 20),

          Text(
            'Add Description',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),

          TextField(
            controller: _resourceNameController,
            decoration: InputDecoration(labelText: 'Enter resource name'),
          ),

          TextField(
            controller: _resourceDescriptionController,
            decoration: InputDecoration(labelText: 'Enter reour description'),
          ),
          TextField(
            controller: _teacherNameController,
            decoration: InputDecoration(labelText: 'Enter teacher name'),
          ),

          TextField(
            controller: _semesterController,
            decoration: InputDecoration(labelText: 'Enter  semester'),
          ),

          TextField(
            controller: _yearController,
            decoration: InputDecoration(labelText: 'Enter year'),
          ),

          const SizedBox(height: 20),

          Text(
            'Upload This',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: _uploadResource,
            child: const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}
