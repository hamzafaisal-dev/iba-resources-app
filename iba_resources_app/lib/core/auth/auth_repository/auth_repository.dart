import 'package:firebase_auth/firebase_auth.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/models/user.dart';

class AuthRepository {
  UserFirebaseClient userFirebaseClient;

  AuthRepository({required this.userFirebaseClient});

  Stream<User?> userStateChangeStream() {
    return userFirebaseClient.userAuthChangeStream;
  }

  Future<UserModel?> getCurrentUser(User? user) {
    return userFirebaseClient.getCurrentUser(user);
  }

  Future<UserCredential> handleLogin(String email, String password) async {
    return await userFirebaseClient.handleLogin(email, password);
  }

  Future<UserCredential> loginWithGoogle() async {
    return await userFirebaseClient.signInWithGoogle();
  }

  Future<UserCredential> loginWithFacebook() async {
    return await userFirebaseClient.signInWithFacebook();
  }

  Future<void> handleSignUp(String name, String email, String password) async {
    return await userFirebaseClient.handleSignUp(name, email, password);
  }

  Future<void> signUpWithGoogle() async {
    return await userFirebaseClient.signUpWithGoogle();
  }

  Future<void> signUpWithFacebook() async {
    return await userFirebaseClient.signUpWithFacebook();
  }

  void signOut() async {
    await userFirebaseClient.signOut();
  }
}
