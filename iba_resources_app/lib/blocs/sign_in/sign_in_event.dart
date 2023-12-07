part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmittedEvent(this.email, this.password);
}

class SignInWithGoogleEvent extends SignInEvent {}

class SignInWithFacebookEvent extends SignInEvent {}
