import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_stat.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final int levelOnePoints = 100;
  late int pointsCount;
  late UserModel authenticatedUser;

  void logOut() {
    BlocProvider.of<AuthBloc>(context).add(SignOutRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateAuthenticated) {
            print(state.authenticatedUser.name);
          }

          if (state is AuthError) {
            print(state.errorMessage);
          }

          if (state is AuthStateUnauthenticated) {
            NavigationService.routeToReplacementNamed('/login');
          }
        },
        builder: (context, state) {
          print('State in User Screen: $state');

          if (state is AuthStateAuthenticated) {
            authenticatedUser = state.authenticatedUser;
          }

          return ListView(
            children: [
              // prfoile name tile
              UserProfileTile(
                leadingIcon: Icons.person,
                title: state is AuthStateAuthenticated
                    ? state.authenticatedUser.name
                    : 'User',
              ),

              const SizedBox(height: 20),

              // Your Statistics
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'Your Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // user stats scroll
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      //
                      UserProfileStat(
                        statisticValue: 6,
                        statisticName: 'Contributions',
                      ),

                      UserProfileStat(
                        statisticValue: 40,
                        statisticName: 'Points',
                      ),

                      UserProfileStat(
                        statisticValue: 113,
                        statisticName: 'Upvotes',
                      ),

                      UserProfileStat(
                        statisticValue: 34,
                        statisticName: 'Downvotes',
                      ),

                      UserProfileStat(
                        statisticValue: 1,
                        statisticName: 'Reports',
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // points card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          const Text(
                            'Points',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          // X/100 pts.
                          Text(
                            '${authenticatedUser.points}/$levelOnePoints pts.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      LinearPercentIndicator(
                        progressColor: Theme.of(context).colorScheme.primary,
                        percent: authenticatedUser.points / levelOnePoints,
                        padding: EdgeInsets.zero,
                        lineHeight: 8,
                        animation: true,
                      ),

                      const SizedBox(height: 12),

                      // need X pts to advance
                      Row(
                        children: [
                          Text(
                            'You need ${levelOnePoints - authenticatedUser.points} more points to advance to Level 2',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // redeem rewards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'Redeem Rewards',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // enter rewards hub
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // rewards hub card

                  InkWell(
                    onTap: () =>
                        NavigationService.routeToNamed('/contributions'),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Enter Rewards Hub',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(height: 80, width: 190),
                        ],
                      ),
                    ),
                  ),

                  // rewards hub trophies image
                  Positioned(
                    top: -16,
                    right: 18,
                    child: Image.asset(
                      'assets/trophies.png',
                      height: 100,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // log out tile
              UserProfileTile(
                leadingIcon: Icons.logout_outlined,
                leadingIconSize: 30,
                title: 'Log out',
                onTap: logOut,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BlocProvider.of<AuthBloc>(context).close();
    BlocProvider.of<SignInBloc>(context).close();
    super.dispose();
  }
}
