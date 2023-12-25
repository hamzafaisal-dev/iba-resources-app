import 'package:iba_resources_app/core/user/network.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class UserRepository {
  final UserFirestoreClient userFirestoreClient;

  UserRepository({required this.userFirestoreClient});

  Future<List<int>> toggleResourceLike(
      UserModel user, ResourceModel resource) async {
    return await userFirestoreClient.toggleResourceLike(user, resource);
  }

  Future<List<int>> toggleResourceDisLike(
      UserModel user, ResourceModel resource) async {
    return await userFirestoreClient.toggleResourceDisLike(user, resource);
  }

  void editProfile(UserModel user) {
    userFirestoreClient.editProfile(user);
  }

  Future<UserModel> fetchCurrentUser(String userId) {
    return userFirestoreClient.fetchCurrentUser(userId);
  }
}
