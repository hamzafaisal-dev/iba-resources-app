import 'package:bloc/bloc.dart';
import 'package:iba_resources_app/core/rewards/rewards_repository.dart';
import 'package:iba_resources_app/models/reward_level.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final RewardRepository rewardRepository;

  RewardsBloc({required this.rewardRepository}) : super(RewardsEmpty()) {
    on<FetchRewardsEvent>((event, emit) async {
      try {
        emit(RewardsLoading());
        List<RewardLevelModel> rewardsList =
            await rewardRepository.getAllRewards();
        emit(RewardsLoaded(rewards: rewardsList));
      } catch (error) {
        emit(RewardsError(errorMsg: error.toString()));
      }
    });
  }
}
