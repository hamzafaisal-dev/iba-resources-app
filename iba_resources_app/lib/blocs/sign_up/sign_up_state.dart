part of 'sign_up_bloc.dart';

abstract class SignUpState {}

final class SignUpInitialState extends SignUpState {}

class SignUpValidState extends SignUpState {}

class SignUpNotValidState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMessage;

  SignUpErrorState(this.errorMessage);
}

class SignUpLoadingState extends SignUpState {}
