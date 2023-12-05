import 'package:firebase_auth/firebase_auth.dart';
import 'package:iba_resources_app/core/auth/network.dart';

class AuthRepository {
  UserFirebaseClient userFirebaseClient;

  AuthRepository({required this.userFirebaseClient});

  Future<void> handleLogin(String email, String password) async {
    return await userFirebaseClient.handleLogin(email, password);
  }

  Future<UserCredential> loginWithGoogle() async {
    return await userFirebaseClient.signInWithGoogle();
  }

  Future<UserCredential> loginWithFacebook() async {
    return await userFirebaseClient.signInWithFacebook();
  }
}
