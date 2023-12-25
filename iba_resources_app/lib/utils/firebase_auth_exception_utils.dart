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
      case 'cancelled':
        errorStatement = 'Sign-In process cancelled';
      case 'missing_auth_details':
        errorStatement = 'Authentication details missing';
      case 'firebase_auth/network-request-failed':
        errorStatement = 'Error. Please check your internet connection';
      default:
        errorStatement = error.message.toString();
    }

    return errorStatement;
  }
}
