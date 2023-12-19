import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/user.dart';

class UserFirestoreClient {
  final FirebaseFirestore firebaseFirestore;

  const UserFirestoreClient({required this.firebaseFirestore});

  // void fetchCurrentUser(String userId) {
  //   firebaseFirestore.collection('users').doc(userId).get();
  // }

  Future<UserModel> fetchCurrentUser(String userId) async {
    // fetches all documents in the resources collection
    final user = await firebaseFirestore.collection('users').doc(userId).get();

    if (!user.exists) throw 'User not found';

    Map<String, dynamic> fetchedUserJson = user.data()!;

    UserModel fetchedUser = UserModel.fromJson(fetchedUserJson);

    return fetchedUser;
  }

  // Stream<UserModel> streamCurrentUser(String userId) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .snapshots()
  //       .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //     if (snapshot.exists) {
  //       // If the document exists, parse the data into UserModel
  //       return UserModel.fromJson(snapshot.data()!);
  //     } else {
  //       // If the document doesn't exist, return a default UserModel or null
  //       throw 'User does not exist'; // Replace with your logic or return null
  //     }
  //   });
  // }

  void editProfile(UserModel user, String userName) async {
    // UserModel updatedUser = user.copyWith(name: userName);
    print(user.name);

    await firebaseFirestore
        .collection('users')
        .doc(user.userId)
        .update(user.toMap());
  }
}
