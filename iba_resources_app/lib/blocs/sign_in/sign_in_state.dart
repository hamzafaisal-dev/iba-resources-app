part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidState extends SignInState {
  final User authenticatedUser;

  SignInValidState(this.authenticatedUser);
}

class SignInNotValidState extends SignInState {}

class SignInInErrorState extends SignInState {
  final String? errorMessage;

  SignInInErrorState(this.errorMessage);
}

class SignInLoadingState extends SignInState {}
