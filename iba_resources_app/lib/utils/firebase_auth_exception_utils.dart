import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionErrors {
  static String getFirebaseError(FirebaseAuthException error) {
    String errorStatement;

    switch (error.code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        errorStatement = 'Invalid login credentials';
      case 'invalid-email':
        errorStatement = 'Invalid email';
      case 'wrong-password':
        errorStatement = 'Wrong password';
      case 'email-already-in-use':
        errorStatement = 'Email already in use';
      default:
        errorStatement = error.message.toString();
    }

    return errorStatement;
  }
}
