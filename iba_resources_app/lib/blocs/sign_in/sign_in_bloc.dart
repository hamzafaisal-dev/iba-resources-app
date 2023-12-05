import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
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
      await authRepository.handleLogin(email, password);

      print('Email and pass is: $email + $password');

      emit(SignInValidState());
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
      UserCredential user = await authRepository.loginWithGoogle();

      if (user.user == null) emit(SignInInErrorState('User does not exist'));

      emit(SignInValidState());
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
      UserCredential user = await authRepository.loginWithFacebook();

      if (user.user == null) emit(SignInInErrorState('User does not exist'));

      emit(SignInValidState());
    } on FirebaseAuthException catch (error) {
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignInInErrorState(firebaseAuthError));
    } catch (e) {
      emit(SignInInErrorState(e.toString()));
    }
  }
}
