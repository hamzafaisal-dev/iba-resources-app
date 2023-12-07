import 'package:iba_resources_app/core/resource/network.dart';
import 'package:iba_resources_app/models/resource.dart';

class ResourceRepository {
  final ResourceFirestoreClient resourceFirestoreClient;

  ResourceRepository({required this.resourceFirestoreClient});

  Future<List<ResourceModel>> getAllResources() async {
    return await resourceFirestoreClient.getAllResources();
  }
}
