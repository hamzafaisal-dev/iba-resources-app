import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthUnknown()) {
    print('shooty bake');

    authRepository.userStateChangeStream().listen((user) async {
      UserModel currentUser = await authRepository.getCurrentUser(user);

      add(AuthStateChangedEvent(currentUser));
    });

    on<AuthStateChangedEvent>((event, emit) {
      event.user != null
          ? emit(AuthStateAuthenticated(event.user!))
          : emit(AuthStateUnauthenticated());
    });

    on<SignOutRequestedEvent>((event, emit) {
      try {
        emit(SigningOutState());
        authRepository.signOut();
        emit(AuthStateUnauthenticated());
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });
  }
}
