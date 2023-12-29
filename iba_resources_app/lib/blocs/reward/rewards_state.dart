part of 'rewards_bloc.dart';

abstract class RewardsState extends Equatable {
  const RewardsState([List props = const []]) : super();
}

// initial state
class RewardsEmpty extends RewardsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RewardsLoading extends RewardsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RewardsLoaded extends RewardsState {
  final List<RewardLevelModel> rewards;

  RewardsLoaded({required this.rewards}) : super([rewards]);

  @override
  // TODO: implement props
  List<Object?> get props => [rewards];
}

class RewardsError extends RewardsState {
  final String errorMsg;
  RewardsError({required this.errorMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMsg];
}
