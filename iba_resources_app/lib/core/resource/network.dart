import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

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

  // Future<void> bookmarkResource(
  //     String resourceId, UserModel user, bool isBookMarked) async {
  //   late UserModel updatedUser;
  //   List<String>? usersSavedResources = user.savedResources;

  //   // have to toggle isBookMarked bec previous value is being passed in, lazy state or something
  //   isBookMarked = !isBookMarked;

  //   print('resource id in resource network: $resourceId');

  //   if (isBookMarked) {
  //     updatedUser = user.copyWith(
  //         savedResources: [...(usersSavedResources ?? []), resourceId]);
  //   } else {
  //     if (usersSavedResources != null) {
  //       // filter the list of saved resources, if any matches the passed in resourceId, it will be removed from list
  //       usersSavedResources = usersSavedResources
  //           .where((savedResourceId) => savedResourceId != resourceId)
  //           .toList();

  //       updatedUser = user.copyWith(savedResources: usersSavedResources);
  //     }
  //   }

  //   await firestore
  //       .collection('users')
  //       .doc(user.userId)
  //       .update(updatedUser.toMap());
  // }

  Future<void> bookmarkResource(
    String resourceId,
    UserModel user,
    bool isBookMarked,
  ) async {
    late UserModel updatedUser;
    List<String>? usersSavedResources = user.savedResources ?? [];

    // have to toggle isBookMarked bec previous value is being passed in, lazy state or something
    isBookMarked = !isBookMarked;

    print('resource id in resource network: $resourceId');

    if (isBookMarked) {
      // add resourceId to the list if not already present
      if (!usersSavedResources.contains(resourceId)) {
        usersSavedResources.add(resourceId);
      }
    } else {
      // remove resourceId from the list
      usersSavedResources.remove(resourceId);
    }

    // update the user model with the modified savedResources list
    updatedUser = user.copyWith(savedResources: usersSavedResources);

    // update the user document in Firestore
    await firestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());
  }
}
