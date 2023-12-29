import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/blocs/reward/rewards_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/core/rewards/rewards_repository.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import '../mock.dart';

class MockFirebase implements Firebase {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  // setupFirebaseAuthMocks();

  group('RewardsBloc', () {
    late AuthRepository authRepository;
    late ResourceRepository resourceRepository;

    late AuthBloc authBloc;
    late ResourceBloc resourceBloc;

    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );

      authRepository = AuthRepository(
        userFirebaseClient: UserFirebaseClient(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
        ),
      );

      resourceRepository = MockResourceRepository();

      authBloc = AuthBloc(authRepository: authRepository);

      resourceBloc = ResourceBloc(
        resourceRepository: resourceRepository,
        authBloc: authBloc,
      );

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );

      // print(resourceBloc);
    });

    tearDown(() {
      resourceBloc.close();
    });

    test('initial state is correct', () {
      // print('gucci');
      expect(
        resourceBloc.state,
        equals(ResourceEmpty()),
      );
    });

    blocTest<ResourceBloc, ResourceState>(
      "test for downloads success",
      build: () => resourceBloc,
      act: (bloc) =>
          bloc.add(const DownloadResourceEvent(fileDownloadUrls: [])),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ResourceFilesDownloadLoading>(),
        isA<ResourceFilesDownloadSuccess>(),
      ],
    );
  });
}
