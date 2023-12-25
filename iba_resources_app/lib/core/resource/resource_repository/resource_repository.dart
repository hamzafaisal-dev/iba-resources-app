import 'package:file_picker/file_picker.dart';
import 'package:iba_resources_app/core/resource/network.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class ResourceRepository {
  final ResourceFirestoreClient resourceFirestoreClient;

  ResourceRepository({required this.resourceFirestoreClient});

  Future<List<ResourceModel>> getAllResources() async {
    return await resourceFirestoreClient.getAllResources();
  }

  Stream<List<ResourceModel>> getAllResourcesStream() {
    return resourceFirestoreClient.getAllResourcesStream();
  }

  Future<List<ResourceModel>> getSearchedResources(String searchedName) async {
    return await resourceFirestoreClient.getSearchedResources(searchedName);
  }

  Future<void> downloadResource(List<dynamic> fileDownloadUrls) async {
    await resourceFirestoreClient.downloadResource(fileDownloadUrls);
  }

  Future<void> bookmarkResource(
      ResourceModel savedResource, UserModel user, bool isBookMarked) async {
    await resourceFirestoreClient.bookmarkResource(
      savedResource,
      user,
      isBookMarked,
    );
  }

  Future<FilePickerResult?> selectFiles() async {
    return await resourceFirestoreClient.selectFiles();
  }

  Future<UserModel> uploadResource(
    FilePickerResult pickedFiles,
    String resourceTitle,
    String resourceDescription,
    String resourceType,
    String teacherName,
    String courseName,
    List<String> relevantFields,
    String semester,
    String year,
    UserModel updatedUser,
  ) {
    return resourceFirestoreClient.uploadResource(
      pickedFiles,
      resourceTitle,
      resourceDescription,
      resourceType,
      teacherName,
      courseName,
      relevantFields,
      semester,
      year,
      updatedUser,
    );
  }
}
