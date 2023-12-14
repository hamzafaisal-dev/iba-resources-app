import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/user.dart';

class UserFirestoreClient {
  final FirebaseFirestore firebaseFirestore;

  const UserFirestoreClient({required this.firebaseFirestore});

  void editProfile(UserModel user, String userName) async {
    UserModel updatedUser = user.copyWith(name: userName);

    await firebaseFirestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());
  }
}
