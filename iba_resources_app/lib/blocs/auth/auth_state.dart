part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthUnknown extends AuthState {}

final class AuthStateAuthenticated extends AuthState {
  final UserModel authenticatedUser;

  AuthStateAuthenticated(this.authenticatedUser);
}

final class AuthStateUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String? errorMessage;

  AuthError(this.errorMessage);
}

final class SigningOutState extends AuthState {}
