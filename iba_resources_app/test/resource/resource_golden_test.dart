import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/reward/rewards_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/core/rewards/rewards_network.dart';
import 'package:iba_resources_app/core/rewards/rewards_repository.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/rewards_screen.dart';

void main() {
  testGoldens('RewardsScreen golden test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AuthRepository authRepository = AuthRepository(
      userFirebaseClient: UserFirebaseClient(
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      ),
    );

    RewardRepository rewardRepository = RewardRepository(
      rewardsFirestoreClient:
          RewardFirestoreClient(firestore: FirebaseFirestore.instance),
    );

    final authBloc = AuthBloc(authRepository: authRepository);
    final rewardsBloc = RewardsBloc(rewardRepository: rewardRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<RewardsBloc>.value(value: rewardsBloc),
          ],
          child: const RewardsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'rewards_screen');
  });
}
