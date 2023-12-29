part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {}

final class SignUpInitialState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpValidState extends SignUpState {
  final UserModel newUser;

  SignUpValidState(this.newUser);

  @override
  List<Object?> get props => [newUser];
}

class SignUpNotValidState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  final String errorMessage;

  SignUpErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}
