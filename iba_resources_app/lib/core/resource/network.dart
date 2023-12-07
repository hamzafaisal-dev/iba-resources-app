import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';

class ResourceFirestoreClient {
  final FirebaseFirestore firestore;

  ResourceFirestoreClient({required this.firestore});

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
}
