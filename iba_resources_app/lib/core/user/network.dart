import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class UserFirestoreClient {
  final FirebaseFirestore firebaseFirestore;

  const UserFirestoreClient({required this.firebaseFirestore});

  Future<UserModel> fetchCurrentUser(String userId) async {
    // fetches all documents in the resources collection
    final user = await firebaseFirestore.collection('users').doc(userId).get();

    if (!user.exists) throw 'User not found';

    Map<String, dynamic> fetchedUserJson = user.data()!;

    UserModel fetchedUser = UserModel.fromJson(fetchedUserJson);

    return fetchedUser;
  }

  Future<List<int>> toggleResourceLike(
      UserModel user, ResourceModel resource) async {
    if (user.likedResources == null || user.dislikedResources == null)
      return [];

    List<ResourceModel> usersLikedResources = user.likedResources!;
    List<ResourceModel> usersDisikedResources = user.dislikedResources!;

    int resourceLikes = resource.likes;
    int resourceDislikes = resource.dislikes;

    // check if the resourceId matches
    bool isResourceMatch(ResourceModel likedResource) {
      return likedResource.resourceId == resource.resourceId;
    }

    // if resource in liked but not disliked: remove from liked
    if (usersLikedResources.any(isResourceMatch) &&
        !usersDisikedResources.any(isResourceMatch)) {
      print('foo1');

      // find the liked resource by resourceId
      ResourceModel likedResource =
          usersLikedResources.firstWhere(isResourceMatch);

      user.likedResources!.remove(likedResource);
      resourceLikes -= 1;
    }

    // if resource neither in liked nor disliked: add to liked
    else if (!usersLikedResources.any(isResourceMatch) &&
        !usersDisikedResources.any(isResourceMatch)) {
      print('foo2');

      resourceLikes += 1;

      user.likedResources!.add(resource);
    }

    // if resource not in liked but in disliked: remove from disliked and add to liked
    else if (!usersLikedResources.any(isResourceMatch) &&
        usersDisikedResources.any(isResourceMatch)) {
      //
      print('foo3');

      usersDisikedResources.removeWhere(isResourceMatch);

      usersLikedResources.add(resource);

      resourceDislikes -= 1;
      resourceLikes += 1;
    }

    // update the user model according to change in likes/dislikes
    UserModel updatedUser = user.copyWith(
      likedResources: usersLikedResources,
      dislikedResources: usersDisikedResources,
    );

    // update the resource model according to change in likes/dislikes
    ResourceModel updatedResource = resource.copyWith(
      likes: resourceLikes,
      dislikes: resourceDislikes,
    );

    // find resource by id and update it in firestore
    await firebaseFirestore
        .collection('resources')
        .doc(updatedResource.resourceId)
        .update(updatedResource.toMap());

    // update user in firestore
    editProfile(updatedUser);

    DocumentSnapshot newUpdatedResourceSnapshot = await firebaseFirestore
        .collection('resources')
        .doc(updatedResource.resourceId)
        .get();

    ResourceModel newUpdatedResource = ResourceModel.fromJson(
        newUpdatedResourceSnapshot.data() as Map<String, dynamic>);

    return [newUpdatedResource.likes, newUpdatedResource.dislikes];
  }

  Future<List<int>> toggleResourceDisLike(
      UserModel user, ResourceModel resource) async {
    if (user.likedResources == null || user.dislikedResources == null)
      return [];

    List<ResourceModel> usersLikedResources = user.likedResources!;
    List<ResourceModel> usersDisikedResources = user.dislikedResources!;

    int resourceLikes = resource.likes;
    int resourceDislikes = resource.dislikes;

    // check if the resourceId matches
    bool isResourceMatch(ResourceModel dislikedResource) {
      return dislikedResource.resourceId == resource.resourceId;
    }

    // if resource in disliked but not disliked: remove from disliked
    if (usersDisikedResources.any(isResourceMatch)) {
      print('foo4');

      // find the liked resource by resourceId
      ResourceModel dislikedResource =
          usersDisikedResources.firstWhere(isResourceMatch);

      user.dislikedResources!.remove(dislikedResource);
      resourceDislikes -= 1;
    }

    // if resource neither in liked nor disliked: add to disliked
    else if (!usersLikedResources.any(isResourceMatch) &&
        !usersDisikedResources.any(isResourceMatch)) {
      print('foo5');

      resourceDislikes += 1;

      user.dislikedResources!.add(resource);
    }

    // if resource not in disliked but in liked: remove from liked and add to disliked
    else if (!usersDisikedResources.any(isResourceMatch) &&
        usersLikedResources.any(isResourceMatch)) {
      print('foo6');

      //
      usersLikedResources.removeWhere(isResourceMatch);

      usersDisikedResources.add(resource);

      resourceLikes -= 1;
      resourceDislikes += 1;
    }

    // update the user model according to change in likes/dislikes
    UserModel updatedUser = user.copyWith(
      likedResources: usersLikedResources,
      dislikedResources: usersDisikedResources,
    );

    // update the resource model according to change in likes/dislikes
    ResourceModel updatedResource = resource.copyWith(
      likes: resourceLikes,
      dislikes: resourceDislikes,
    );

    // find resource by id and update it in firestore
    await firebaseFirestore
        .collection('resources')
        .doc(updatedResource.resourceId)
        .update(updatedResource.toMap());

    // update user in firestore
    editProfile(updatedUser);

    DocumentSnapshot newUpdatedResourceSnapshot = await firebaseFirestore
        .collection('resources')
        .doc(updatedResource.resourceId)
        .get();

    ResourceModel newUpdatedResource = ResourceModel.fromJson(
        newUpdatedResourceSnapshot.data() as Map<String, dynamic>);

    return [newUpdatedResource.likes, newUpdatedResource.dislikes];
  }

  void editProfile(UserModel user) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.userId)
        .update(user.toMap());
  }
}
