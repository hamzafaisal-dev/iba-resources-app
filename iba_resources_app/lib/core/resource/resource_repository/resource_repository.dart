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

  Stream<List<ResourceModel>> getSearchedResources(String searchedName) {
    return resourceFirestoreClient.getSearchedResources(searchedName);
  }

  Stream<List<ResourceModel>> getFilteredResources(
      Map<String, dynamic> filters) {
    return resourceFirestoreClient.getFilteredResources(filters);
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

  Future<UserModel> deleteResource(String resourceId, UserModel user) async {
    return await resourceFirestoreClient.deleteResource(resourceId, user);
  }
}
