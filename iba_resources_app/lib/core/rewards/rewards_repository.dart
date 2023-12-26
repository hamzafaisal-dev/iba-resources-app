import 'package:iba_resources_app/core/rewards/rewards_network.dart';
import 'package:iba_resources_app/models/reward.dart';
import 'package:iba_resources_app/models/reward_level.dart';

class RewardRepository {
  final RewardFirestoreClient rewardsFirestoreClient;

  RewardRepository({required this.rewardsFirestoreClient});

  Future<List<RewardLevelModel>> getAllRewards() async {
    return await rewardsFirestoreClient.getAllRewards();
  }
}
