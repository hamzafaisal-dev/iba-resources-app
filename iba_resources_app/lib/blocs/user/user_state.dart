part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserUpdateSuccess extends UserState {}

class UserUpdateError extends UserState {
  final String errorMessage;

  UserUpdateError({required this.errorMessage});
}

class UserLoadingState extends UserState {}

class UserLoaded extends UserState {
  final UserModel currentUser;

  UserLoaded(this.currentUser);
}
