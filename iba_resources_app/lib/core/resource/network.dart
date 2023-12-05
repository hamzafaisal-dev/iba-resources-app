import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';

class ResourceFirestoreClient {
  final FirebaseFirestore firestore;

  ResourceFirestoreClient({required this.firestore});

  Future<List<Resource>> getAllResources() async {
    // fetches all documents in the resources collection
    final resources =
        await firestore.collection('resources').orderBy('createdAt').get();

    // resources.docs returns a list of QueryDocumentSnapshot
    // maps over the list, converts each document into a Resource, returns list of Resources
    List<Resource> allFetchedResources = resources.docs.map((docSnapshot) {
      return Resource.fromJson(docSnapshot.data());
    }).toList();

    return allFetchedResources;
  }
}
