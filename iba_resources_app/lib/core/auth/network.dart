import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserFirebaseClient {
  final FirebaseAuth firebaseAuth;

  UserFirebaseClient({
    required this.firebaseAuth,
  });

  Future<void> handleLogin(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // google sign-in
  Future<UserCredential> signInWithGoogle() async {
    print('we here g');

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'cancelled',
          message: 'Google Sign-In process cancelled',
        );
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth == null) {
        throw FirebaseAuthException(
          code: 'missing_auth_details',
          message: 'Authentication details missing',
        );
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await firebaseAuth.signInWithCredential(credential);

      // if (user.user == null) return;

      // QuerySnapshot userQuery = await firestore
      //     .collection('users')
      //     .where('uid', isEqualTo: user.user!.uid)
      //     .get();

      // if (userQuery.docs.isNotEmpty) {
      //   // we gucci
      // }
    } catch (error) {
      // throws OG error if error not related to cancellation
      rethrow;
    }
  }

  // facebook sign-in
  Future<UserCredential> signInWithFacebook() async {
    print('we here f');

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw FirebaseAuthException(
        code: 'cancelled',
        message: 'Facebook Sign-In process cancelled',
      );
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
