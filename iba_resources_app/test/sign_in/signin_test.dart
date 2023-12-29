import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:mockito/mockito.dart';

import '../mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirestoreAuth extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  setupFirebaseAuthMocks();

  group('SignInBloc', () {
    late AuthRepository authRepository;
    late SignInBloc signInBloc;
    late UserModel user;

    setUpAll(() async {
      authRepository = AuthRepository(
        userFirebaseClient: UserFirebaseClient(
          firebaseAuth: MockFirebaseAuth(),
          firestore: MockFirestoreAuth(),
        ),
      );
      signInBloc = SignInBloc(authRepository: authRepository);

      print(authRepository);
      print(signInBloc.authRepository);

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      user = UserModel(
        userId: 'ewkvtrhr3475y437gr432u61r28e',
        role: 'user',
        name: 'Hamza Faisal',
        email: 'h.faisal.22972@khi.iba.edu.pk',
        avatar:
            'https://api.dicebear.com/5.x/pixel-art/svg?seed=k2yO7d9rVNZoiV83Knbnr39Hx9jCXKTkJ7KiGuzyJ',
        postedResources: [],
        savedResources: [],
        likedResources: [],
        dislikedResources: [],
        points: 0,
        reportCount: 0,
        isBanned: false,
        createdAt: DateTime.now(),
        updatedAt: null,
        isActive: true,
        isDeleted: false,
      );
    });

    tearDown(() {
      signInBloc.close();
    });

    test('initial state is correct', () {
      expect(signInBloc.state, equals(SignInInitialState()));
    });

    blocTest<SignInBloc, SignInState>(
      'handleLogin emits [loading, success] states on successful sign-in',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(
          authRepository.handleLogin(
              'h.faisal.22972@khi.iba.edu.pk', 'test123'),
        ).thenAnswer((_) async => Future.value(user));

        bloc.add(
            SignInSubmittedEvent('h.faisal.22972@khi.iba.edu.pk', 'test123'));
      },
      expect: () => [SignInLoadingState(), SignInValidState(user)],
    );

    blocTest<SignInBloc, SignInState>(
      'handleLogin emits [loading, error] states on sign-in error',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(authRepository.handleLogin(
                'h.faisal.22972@khi.iba.edu.pk', 'test1234'))
            .thenThrow(FirebaseAuthException(code: 'invalid-credentials'));

        bloc.add(
            SignInSubmittedEvent('h.faisal.22972@khi.iba.edu.pk', 'test1234'));
      },
      expect: () =>
          [SignInLoadingState(), SignInInErrorState('Invalid credentials')],
    );

    blocTest<SignInBloc, SignInState>(
      'SignInWithGoogleEvent emits [loading, success] states on successful Google sign-in',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(authRepository.loginWithGoogle()).thenAnswer(
          (_) async => Future.value(user),
        );

        bloc.add(SignInWithGoogleEvent());
      },
      expect: () => [SignInLoadingState(), SignInValidState(user)],
    );

    blocTest<SignInBloc, SignInState>(
      'SignInWithGoogleEvent emits [loading, error] states on Google sign-in error',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(authRepository.loginWithGoogle())
            .thenThrow(FirebaseAuthException(code: 'google-sign-in-error'));

        bloc.add(SignInWithGoogleEvent());
      },
      expect: () =>
          [SignInLoadingState(), SignInInErrorState('Google sign-in error')],
    );

    blocTest<SignInBloc, SignInState>(
      'SignInWithFacebookEvent emits [loading, success] states on successful Facebook sign-in',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(authRepository.loginWithFacebook()).thenAnswer(
          (_) async => Future.value(user),
        );

        bloc.add(SignInWithFacebookEvent());
      },
      expect: () => [SignInLoadingState(), SignInValidState(user)],
    );

    blocTest<SignInBloc, SignInState>(
      'SignInWithFacebookEvent emits [loading, error] states on Facebook sign-in error',
      build: () => SignInBloc(authRepository: authRepository),
      act: (bloc) async {
        when(authRepository.loginWithFacebook())
            .thenThrow(FirebaseAuthException(code: 'facebook-sign-in-error'));

        bloc.add(SignInWithFacebookEvent());
      },
      expect: () =>
          [SignInLoadingState(), SignInInErrorState('Facebook sign-in error')],
    );

    //     blocTest<ResourceBloc, ResourceState>(
    //   "test for Read success",
    //   build: () => userBloc,
    //   act: (bloc) => bloc.add(const readUser_Event(uid: "1")),
    //   wait: const Duration(seconds: 2),
    //   expect: () => [isA<BlocInitial>(), isA<BlocLoad>(), isA<BlocSuccess>()],
    // );
  });
}
