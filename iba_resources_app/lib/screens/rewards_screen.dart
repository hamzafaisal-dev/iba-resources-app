import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/reward/rewards_bloc.dart';
import 'package:iba_resources_app/models/reward.dart';
import 'package:iba_resources_app/models/reward_level.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/widgets/profile/reward_tile.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  late UserModel _authenticatedUser;

  @override
  void initState() {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }

    // fetch rewards only if they haven't been loaded before
    final rewardsBloc = BlocProvider.of<RewardsBloc>(context);
    if (rewardsBloc.state is! RewardsLoaded) {
      rewardsBloc.add(FetchRewardsEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<RewardsBloc, RewardsState>(
          builder: (context, state) {
            print(state);

            if (state is RewardsLoaded) {
              return ListView.builder(
                itemCount: state.rewards[0].rewardsList.length,
                itemBuilder: (context, index) {
                  List<RewardModel> rewardsList = state.rewards[0].rewardsList;

                  RewardModel reward = rewardsList[index];

                  return RewardTile(
                    title: reward.rewardName,
                    rewardPoints: reward.rewardPoints,
                    userPoints: _authenticatedUser.points,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('My Rewards'),
//       centerTitle: true,
//     ),
//     body: Stack(
//       children: [
//         Center(
//           child: Container(
//             width: 30,
//             height: MediaQuery.of(context).size.height - 200,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20.0),
//                 topRight: Radius.circular(20.0),
//                 bottomLeft: Radius.circular(20.0),
//                 bottomRight: Radius.circular(20.0),
//               ),
//             ),
//           ),
//         ),
//         const RewardCircle(
//           circleText: 'Reward 1',
//           top: 0.0,
//         ),
//         const RewardPoints(
//           pointsTextAlignment: 'left',
//           points: 0,
//           totalPoints: 50,
//           top: 38.0,
//         ),
//         const RewardCircle(
//           circleText: 'Reward 2',
//           top: 140.0,
//         ),
//         const RewardPoints(
//           pointsTextAlignment: 'right',
//           points: 0,
//           totalPoints: 100,
//           top: 178.0,
//         ),
//         const RewardCircle(
//           circleText: 'Reward 3',
//           top: 280.0,
//         ),
//         const RewardPoints(
//           pointsTextAlignment: 'left',
//           points: 0,
//           totalPoints: 150,
//           top: 318.0,
//         ),
//         const RewardCircle(
//           circleText: 'Reward 4',
//           top: 420.0,
//         ),
//         const RewardPoints(
//           pointsTextAlignment: 'right',
//           points: 0,
//           totalPoints: 200,
//           top: 458.0,
//         ),
//         const RewardCircle(
//           circleText: 'Reward 5',
//           top: 560.0,
//         ),
//         const RewardPoints(
//           pointsTextAlignment: 'left',
//           points: 0,
//           totalPoints: 250,
//           top: 598.0,
//         ),
//       ],
//     ),
//   );
// }

class RewardCircle extends StatelessWidget {
  const RewardCircle({super.key, required this.circleText, required this.top});

  final String circleText;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: MediaQuery.of(context).size.width / 2 - 50.0,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            circleText,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class RewardPoints extends StatelessWidget {
  const RewardPoints({
    super.key,
    required this.pointsTextAlignment,
    required this.points,
    required this.totalPoints,
    required this.top,
  });

  final String pointsTextAlignment;
  final int points;
  final int totalPoints;

  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: pointsTextAlignment == 'left'
          ? MediaQuery.of(context).size.width / 2 - 145.0
          : MediaQuery.of(context).size.width / 2 + 70.0,
      child: Text(
        '$points/$totalPoints pts',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
