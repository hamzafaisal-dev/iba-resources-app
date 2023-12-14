part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class UserUpdateEvent extends UserEvent {
  final UserModel user;
  final String name;

  UserUpdateEvent(this.user, this.name);

  @override
  List<Object?> get props => [user, name];
}
