import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iba_resources_app/constants/firebase_constants.dart';
import 'package:iba_resources_app/core/providers/firebase_providers.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';

// create a Provider that provides an instance of the AuthRepository class
final authRepoProvider = Provider(
  (ref) => AuthRepository(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider),
      facebookSignIn: ref.read(facebookSignInProvider)),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuthProvider _facebookSignIn;

  // used initializer list to initalize private variables
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FacebookAuthProvider facebookSignIn,
  })  : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn,
        _facebookSignIn = facebookSignIn;

  CollectionReference get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Future<void> signUp(String name, String email, String password) async {
    try {
      // setState(() {
      //   _isSigningUp = true;
      // });

      final newUserCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel newUser;

      // if user is a new user, only then enter them into dataabse
      if (newUserCredentials.additionalUserInfo!.isNewUser) {
        newUser = UserModel(
          role: 'user',
          name: name,
          email: email,
          postedResources: [],
          savedResources: [],
          points: 0,
          reportCount: 0,
          isBanned: false,
          createdAt: DateTime.now(),
          isActive: true,
          isDeleted: false,
        );

        // set new user in users collection
        await _usersCollection
            .doc(newUserCredentials.user!.uid)
            .set(newUser.toMap())
            .then((value) {
          // setState(() {
          //   _isSigningUp = false;
          // });

          NavigationService.routeToReplacementNamed('/layout');
        });
      }
    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   _isSigningUp = false;
      // });

      // get error statement and display it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(e);
      // showSnackbar(firebaseAuthError);
    } catch (error) {
      print(error);
      // setState(() {
      //   _isSigningUp = false;
      // });

      // showSnackbar('Error: $error');
    }
  }

  // sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    late UserCredential userCredentials;

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      userCredentials = await _auth.signInWithCredential(credential);

      UserModel newUser;

      // if user is a new user, only then enter them into dataabse
      if (userCredentials.additionalUserInfo!.isNewUser) {
        newUser = UserModel(
          role: 'user',
          name: userCredentials.user!.displayName ?? 'No Name',
          email: userCredentials.user!.email!,
          postedResources: [],
          savedResources: [],
          points: 0,
          reportCount: 0,
          isBanned: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isActive: true,
          isDeleted: false,
        );

        // set new user in users collection
        await _usersCollection
            .doc(userCredentials.user!.uid)
            .set(newUser.toMap());
      }
    } catch (error) {
      print(error);
    }

    return userCredentials;
  }

  // sign in with Facebook
  Future<UserCredential> signInWithFacebook() async {
    late UserCredential userCredentials;

    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      userCredentials =
          await _auth.signInWithCredential(facebookAuthCredential);
    } catch (error) {
      print(error);
    }

    return userCredentials;
  }
}
