part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpSubmittedEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  SignUpSubmittedEvent(this.name, this.email, this.password);
}

class SignUpWithGoogleEvent extends SignUpEvent {}

class SignUpWithFacebookEvent extends SignUpEvent {}
