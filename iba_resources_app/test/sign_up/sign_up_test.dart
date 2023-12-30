import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignUpBloc', () {
    final authRepository = MockAuthRepository();
    late SignUpBloc signUpBloc;

    setUp(() async {
      // WidgetsFlutterBinding.ensureInitialized();

      // await Firebase.initializeApp();

      signUpBloc = SignUpBloc(authRepository: authRepository);
    });

    test('initial state is correct', () {
      expect(signUpBloc.state, equals(SignUpInitialState()));
    });

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpSubmittedEvent emits [loading, success] states on successful email/password sign-up',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.handleSignUp(
    //             'John Doe', 'john@example.com', 'test123'))
    //         .thenAnswer((_) async => ());

    //     bloc.add(
    //         SignUpSubmittedEvent('John Doe', 'john@example.com', 'test123'));
    //   },
    //   expect: () => [SignUpLoadingState(), SignUpValidState()],
    // );

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpSubmittedEvent emits [loading, error] states on email/password sign-up error',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.handleSignUp(
    //             'John Doe', 'john@example.com', 'test123'))
    //         .thenThrow(FirebaseAuthException(code: 'email-sign-up-error'));

    //     bloc.add(
    //         SignUpSubmittedEvent('John Doe', 'john@example.com', 'test123'));
    //   },
    //   expect: () =>
    //       [SignUpLoadingState(), SignUpErrorState('Email sign-up error')],
    // );

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpWithGoogleEvent emits [loading, success] states on successful Google sign-up',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.signUpWithGoogle()).thenAnswer((_) async => ());

    //     bloc.add(SignUpWithGoogleEvent());
    //   },
    //   expect: () => [SignUpLoadingState(), SignUpValidState()],
    // );

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpWithGoogleEvent emits [loading, error] states on Google sign-up error',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.signUpWithGoogle())
    //         .thenThrow(FirebaseAuthException(code: 'google-sign-up-error'));

    //     bloc.add(SignUpWithGoogleEvent());
    //   },
    //   expect: () =>
    //       [SignUpLoadingState(), SignUpErrorState('Google sign-up error')],
    // );

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpWithFacebookEvent emits [loading, success] states on successful Facebook sign-up',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.signUpWithFacebook()).thenAnswer((_) async => ());

    //     bloc.add(SignUpWithFacebookEvent());
    //   },
    //   expect: () => [SignUpLoadingState(), SignUpValidState()],
    // );

    // blocTest<SignUpBloc, SignUpState>(
    //   'SignUpWithFacebookEvent emits [loading, error] states on Facebook sign-up error',
    //   build: () => SignUpBloc(authRepository: authRepository),
    //   act: (bloc) async {
    //     when(authRepository.signUpWithFacebook())
    //         .thenThrow(FirebaseAuthException(code: 'facebook-sign-up-error'));

    //     bloc.add(SignUpWithFacebookEvent());
    //   },
    //   expect: () =>
    //       [SignUpLoadingState(), SignUpErrorState('Facebook sign-up error')],
    // );
  });
}
