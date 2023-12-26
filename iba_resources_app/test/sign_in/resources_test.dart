import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:mockito/mockito.dart';

import '../mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  setupFirebaseAuthMocks();

  group('ResourceBloc', () {
    late AuthRepository authRepository;
    late AuthBloc authBloc;

    late ResourceRepository resourceRepository;
    late ResourceBloc resourceBloc;

    setUpAll(() async {
      authRepository = MockAuthRepository();
      resourceRepository = MockResourceRepository();
      authBloc = AuthBloc(authRepository: authRepository);
      resourceBloc = ResourceBloc(
        resourceRepository: resourceRepository,
        authBloc: authBloc,
      );

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();
    });

    tearDown(() {
      resourceBloc.close();
    });

    test('initial state is correct', () {
      expect(
        resourceBloc.state,
        equals(ResourcesLoading()),
      );
    });
  });
}
