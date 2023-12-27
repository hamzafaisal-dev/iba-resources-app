import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:mockito/mockito.dart';

import '../mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  setupFirebaseAuthMocks();

  group('SignInBloc', () {
    late AuthRepository authRepository;
    late SignInBloc signInBloc;

    setUpAll(() async {
      authRepository = MockAuthRepository();
      signInBloc = SignInBloc(authRepository: authRepository);

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();
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
        // Configure the mock to return a Future<UserCredential> on handleLogin
        when(
          authRepository.handleLogin('umarkmemon@khi.iba.edu.pk', 'test123'),
        ).thenAnswer((_) async => Future.value(MockUserCredential()));

        bloc.add(SignInSubmittedEvent('umarkmemon@khi.iba.edu.pk', 'test123'));
      },
      expect: () =>
          [SignInLoadingState(), SignInValidState(MockUserCredential().user!)],
      // verify: (_) {
      //   verify(authRepository.handleLogin(
      //     'umarkmemon@khi.iba.edu.pk',
      //     'test123',
      //   )).called(1);
      // },
    );
  });
}
