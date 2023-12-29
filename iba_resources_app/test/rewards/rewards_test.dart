import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/reward/rewards_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/rewards/rewards_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import '../mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockRewardRepository extends Mock implements RewardRepository {}

void main() {
  setupFirebaseAuthMocks();

  group('RewardsBloc', () {
    late RewardRepository rewardRepository;
    late RewardsBloc rewardsBloc;

    setUpAll(() async {
      rewardRepository = MockRewardRepository();

      rewardsBloc = RewardsBloc(rewardRepository: rewardRepository);

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      print(rewardsBloc);
    });

    tearDown(() {
      rewardsBloc.close();
    });

    test('initial state is correct', () {
      expect(
        rewardsBloc.state,
        equals(RewardsEmpty()),
      );
    });

    blocTest<RewardsBloc, RewardsState>(
      'emits [MyState] when MyEvent is added.',
      build: () => rewardsBloc,
      act: (bloc) => bloc.add(FetchRewardsEvent()),
      expect: () => [RewardsLoading, RewardsLoaded(rewards: [])],
    );

    blocTest<RewardsBloc, RewardsState>(
      'emits [RewardsLoading, RewardsError] when FetchRewardsEvent fails',
      build: () {
        when(rewardRepository.getAllRewards())
            .thenThrow(Exception('Test Error'));
        return rewardsBloc;
      },
      act: (bloc) => bloc.add(FetchRewardsEvent()),
      expect: () => [
        RewardsLoading(),
        RewardsError(errorMsg: 'Test Error'),
      ],
    );
  });
}
