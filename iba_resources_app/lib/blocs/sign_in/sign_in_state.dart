part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {}

class SignInInitialState extends SignInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInValidState extends SignInState {
  final UserModel authenticatedUser;

  SignInValidState(this.authenticatedUser);

  @override
  // TODO: implement props
  List<Object?> get props => [authenticatedUser];
}

class SignInNotValidState extends SignInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInInErrorState extends SignInState {
  final String? errorMessage;

  SignInInErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class SignInLoadingState extends SignInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
