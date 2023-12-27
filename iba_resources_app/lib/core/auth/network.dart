import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iba_resources_app/models/user.dart';

class UserFirebaseClient {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserFirebaseClient({required this.firebaseAuth, required this.firestore});

  Stream<User?> get userAuthChangeStream => firebaseAuth.userChanges();

  // get current user
  Future<UserModel?> getCurrentUser(User? currentUser) async {
    String? currentUserId = currentUser?.uid;

    if (currentUserId == null) return null;

    DocumentSnapshot querySnapshot =
        await firestore.collection('users').doc(currentUserId).get();

    Map<String, dynamic> userMap = querySnapshot.data() as Map<String, dynamic>;

    UserModel user = UserModel.fromJson(userMap);

    return user;
  }

  // email and pass login
  Future<UserModel> handleLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userSnapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel authenticatedUser =
          UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);

      return authenticatedUser;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // google sign-in
  Future<UserModel> signInWithGoogle() async {
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
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      DocumentSnapshot userSnapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel authenticatedUser =
          UserModel.fromJson(userSnapshot as Map<String, dynamic>);

      return authenticatedUser;

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
  Future<UserModel> signInWithFacebook() async {
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
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(userCredential.user!.uid).get();

    UserModel authenticatedUser =
        UserModel.fromJson(userSnapshot as Map<String, dynamic>);

    return authenticatedUser;
  }

  // email and pass sign up
  Future<void> handleSignUp(String name, String email, String password) async {
    final newUserCredentials =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = newUserCredentials.user!.uid;

    UserModel newUser = UserModel(
      userId: userId,
      role: 'user',
      name: name,
      email: email,
      postedResources: [],
      savedResources: [],
      likedResources: [],
      dislikedResources: [],
      points: 0,
      reportCount: 0,
      isBanned: false,
      createdAt: DateTime.now(),
      updatedAt: null,
      isActive: true,
      isDeleted: false,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUserCredentials.user!.uid)
        .set(newUser.toMap());
  }

  // google sign-up
  Future<void> signUpWithGoogle() async {
    print('we here g2');

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
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw FirebaseAuthException(
          code: 'INVALID_LOGIN_CREDENTIALS',
          message: 'Invalid login credentials',
        );
      }

      QuerySnapshot userQuery = await firestore
          .collection('users')
          .where('email', isEqualTo: userCredential.user!.email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'Email already in use',
        );
      }

      String userId = userCredential.user!.uid;

      UserModel newGoogleUser = UserModel(
        userId: userId,
        role: 'user',
        name: userCredential.user!.displayName ?? 'User',
        email: userCredential.user!.email!,
        postedResources: [],
        savedResources: [],
        likedResources: [],
        dislikedResources: [],
        points: 0,
        reportCount: 0,
        isBanned: false,
        createdAt: DateTime.now(),
        updatedAt: null,
        isActive: true,
        isDeleted: false,
      );

      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newGoogleUser.toMap());
    } catch (error) {
      // throws OG error if error not related to cancellation
      rethrow;
    }
  }

  // facebook sign-up
  Future<void> signUpWithFacebook() async {
    print('we here f2');

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
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(facebookAuthCredential);

    if (userCredential.user == null) {
      throw FirebaseAuthException(
        code: 'INVALID_LOGIN_CREDENTIALS',
        message: 'Invalid login credentials',
      );
    }

    QuerySnapshot userQuery = await firestore
        .collection('users')
        .where('email', isEqualTo: userCredential.user!.email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      throw FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'Email already in use',
      );
    }

    String userId = userCredential.user!.uid;

    UserModel newGoogleUser = UserModel(
      userId: userId,
      role: 'user',
      name: userCredential.user!.displayName ?? 'User',
      email: userCredential.user!.email!,
      postedResources: [],
      savedResources: [],
      likedResources: [],
      dislikedResources: [],
      points: 0,
      reportCount: 0,
      isBanned: false,
      createdAt: DateTime.now(),
      updatedAt: null,
      isActive: true,
      isDeleted: false,
    );

    await firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(newGoogleUser.toMap());
  }

  // sign out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
