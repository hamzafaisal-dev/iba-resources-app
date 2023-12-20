part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthStateChangedEvent extends AuthEvent {
  final UserModel? user;

  AuthStateChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthStateUpdatedEvent extends AuthEvent {
  final UserModel? user;

  AuthStateUpdatedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class SignOutRequestedEvent extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
