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

class UserToggleLikeEvent extends UserEvent {
  final UserModel user;
  final ResourceModel resource;

  UserToggleLikeEvent(this.user, this.resource);

  @override
  List<Object?> get props => [user, resource];
}

class UserToggleDislikeEvent extends UserEvent {
  final UserModel user;
  final ResourceModel resource;

  UserToggleDislikeEvent(this.user, this.resource);

  @override
  List<Object?> get props => [user, resource];
}
