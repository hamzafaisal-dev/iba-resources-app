import 'package:iba_resources_app/core/user/network.dart';
import 'package:iba_resources_app/models/user.dart';

class UserRepository {
  final UserFirestoreClient userFirestoreClient;

  UserRepository({required this.userFirestoreClient});

  void editProfile(UserModel user, String userName) {
    userFirestoreClient.editProfile(user, userName);
  }

  Future<UserModel> fetchCurrentUser(String userId) {
    return userFirestoreClient.fetchCurrentUser(userId);
  }
}
