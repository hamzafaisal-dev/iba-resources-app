import 'package:iba_resources_app/core/resource/network.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class ResourceRepository {
  final ResourceFirestoreClient resourceFirestoreClient;

  ResourceRepository({required this.resourceFirestoreClient});

  Future<List<ResourceModel>> getAllResources() async {
    return await resourceFirestoreClient.getAllResources();
  }

  Future<void> bookmarkResource(
      String resourceId, UserModel user, bool isBookMarked) async {
    await resourceFirestoreClient.bookmarkResource(
      resourceId,
      user,
      isBookMarked,
    );
  }
}
