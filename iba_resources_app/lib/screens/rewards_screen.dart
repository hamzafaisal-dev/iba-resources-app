import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/widgets/profile/reward_tile.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return RewardTile(
                  title: 'Reward ${index + 1}',
                  rewardPoints: (index + 1) * 50,
                  userPoints: state is AuthStateAuthenticated
                      ? state.authenticatedUser.points
                      : 0,
                );
              },
            );
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
