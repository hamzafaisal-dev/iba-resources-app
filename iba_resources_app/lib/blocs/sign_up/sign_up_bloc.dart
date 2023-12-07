import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(SignUpInitialState()) {
    on<SignUpSubmittedEvent>((event, emit) async {
      //
      await _signUpWithMailAndPass(
        event.name,
        event.email,
        event.password,
        emit,
      );
    });

    on<SignUpWithGoogleEvent>((event, emit) async {
      await _signUpWithGoogle(emit);
    });

    on<SignUpWithFacebookEvent>((event, emit) async {
      await _signUpWithFacebook(emit);
    });
  }

  Future<void> _signUpWithMailAndPass(
      String name, String email, String password, Emitter emit) async {
    //
    try {
      emit(SignUpLoadingState());

      await authRepository.handleSignUp(name, email, password);

      emit(SignUpValidState());
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignUpErrorState(firebaseAuthError));
    } catch (error) {
      emit(SignUpErrorState(error.toString()));
    }
  }

  Future<void> _signUpWithGoogle(Emitter emit) async {
    //
    try {
      await authRepository.signUpWithGoogle();

      emit(SignUpValidState());
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignUpErrorState(firebaseAuthError));
    } catch (error) {
      emit(SignUpErrorState(error.toString()));
    }
  }

  Future<void> _signUpWithFacebook(Emitter emit) async {
    //
    try {
      await authRepository.signUpWithFacebook();

      emit(SignUpValidState());
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignUpErrorState(firebaseAuthError));
    } catch (error) {
      emit(SignUpErrorState(error.toString()));
    }
  }
}
