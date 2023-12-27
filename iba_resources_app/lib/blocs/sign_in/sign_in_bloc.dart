import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInInitialState()) {
    on<SignInSubmittedEvent>((event, emit) async {
      await _signInWithMailAndPass(emit, event.email, event.password);
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      await _signInWithGoogle(emit);
    });

    on<SignInWithFacebookEvent>((event, emit) async {
      await _signInWithFacebook(emit);
    });
  }

  Future<void> _signInWithMailAndPass(
    Emitter<SignInState> emit,
    String email,
    String password,
  ) async {
    emit(SignInLoadingState());
    try {
      // get user credential from login operation
      UserModel authenticatedUser =
          await authRepository.handleLogin(email, password);

      //  emit valid login state
      emit(SignInValidState(authenticatedUser));
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignInInErrorState(firebaseAuthError));
    } catch (e) {
      emit(SignInInErrorState(e.toString()));
    }
  }

  Future<void> _signInWithGoogle(Emitter<SignInState> emit) async {
    try {
      UserModel authenticatedUser = await authRepository.loginWithGoogle();

      emit(SignInValidState(authenticatedUser));
    } on FirebaseAuthException catch (error) {
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignInInErrorState(firebaseAuthError));
    } catch (e) {
      emit(SignInInErrorState(e.toString()));
    }
  }

  Future<void> _signInWithFacebook(Emitter<SignInState> emit) async {
    try {
      UserModel authenticatedUser = await authRepository.loginWithFacebook();

      emit(SignInValidState(authenticatedUser));
    } on FirebaseAuthException catch (error) {
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignInInErrorState(firebaseAuthError));
    } catch (e) {
      emit(SignInInErrorState(e.toString()));
    }
  }
}
