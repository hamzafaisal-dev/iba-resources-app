part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserUpdateSuccess extends UserState {}

class UserUpdateError extends UserState {
  final String errorMessage;

  UserUpdateError({required this.errorMessage});
}

class UserUpdateLoading extends UserState {}
