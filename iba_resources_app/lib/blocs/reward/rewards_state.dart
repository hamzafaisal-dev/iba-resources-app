part of 'rewards_bloc.dart';

abstract class RewardsState {
  const RewardsState([List props = const []]) : super();
}

// initial state
class RewardsEmpty extends RewardsState {}

class RewardsLoading extends RewardsState {}

class RewardsLoaded extends RewardsState {
  final List<RewardLevelModel> rewards;

  RewardsLoaded({required this.rewards}) : super([rewards]);
}

class RewardsError extends RewardsState {
  final String errorMsg;
  RewardsError({required this.errorMsg});
}
