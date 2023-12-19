part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UserUpdateEvent extends UserEvent {
  final UserModel user;
  final String name;

  UserUpdateEvent(this.user, this.name);

  @override
  List<Object?> get props => [user, name];
}
