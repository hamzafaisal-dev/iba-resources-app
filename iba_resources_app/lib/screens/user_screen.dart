import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_stat.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_tile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

final _firebaseAuth = FirebaseAuth.instance;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool loading = false;

  void logOut() {
    setState(() {
      loading = true;
    });

    _firebaseAuth.signOut().then(
      (value) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          // prfoile name tile
          const UserProfileTile(
            leadingIcon: Icons.person,
            title: 'Farhan Mushi',
          ),

          const SizedBox(height: 20),

          // Your Statistics
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  'Your Statistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

                      Text(
                        '40/120 pts.',
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
                    // fillColor: Theme.of(context).colorScheme.primary,
                    progressColor: Theme.of(context).colorScheme.primary,
                    percent: 0.4,
                    padding: EdgeInsets.zero,
                    lineHeight: 8,
                    animation: true,
                  ),

                  const SizedBox(height: 12),

                  const Row(
                    children: [
                      Text(
                        'You need 60 more points to advance to Level 2',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF8C959C),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  'Redeem Rewards',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
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
                onTap: () => Navigator.of(context).pushNamed("/contributions"),
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
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
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
            leadingIcon: Icons.logout,
            leadingIconSize: 30,
            title: 'Log out',
            onTap: logOut,
          ),
        ],
      ),
    );
  }
}
