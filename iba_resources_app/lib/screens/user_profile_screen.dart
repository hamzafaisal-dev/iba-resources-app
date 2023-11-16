import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:iba_resources_app/widgets/profile_action_tile.dart';
import 'package:iba_resources_app/widgets/profile_stat.dart';

final _firebaseAuth = FirebaseAuth.instance;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool loading = false;

  void logOut() {
    setState(() {
      loading = true;
    });

    _firebaseAuth.signOut().then(
          (value) => {
            setState(() {
              loading = false;
            }),
            Navigator.of(context).pushReplacementNamed('/login'),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // profile details
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 253, 127, 118),
            image: DecorationImage(
              image: AssetImage(
                'assets/bank-note.png',
              ),
              opacity: 0.06,
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              const SizedBox(height: 25),

              // user pfp
              CircleAvatar(
                radius: 65,
                backgroundColor: const Color.fromARGB(255, 240, 99, 89),
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: Colors.grey[200],
                ),
              ),

              const SizedBox(height: 20),

              // user name
              Text(
                'Farhan Mushi',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      offset: const Offset(
                        2.0,
                        2.5,
                      ),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(
                        0.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // profile stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //
                  ProfileStat(
                    icon: Icon(
                      Icons.star,
                      size: 40,
                      color: Colors.grey[200],
                    ),
                    statisticName: 'Points',
                    statisticValue: 26,
                  ),

                  ProfileStat(
                    icon: Icon(
                      Icons.group,
                      size: 38,
                      color: Colors.grey[200],
                    ),
                    statisticName: 'Contributions',
                    statisticValue: 9,
                  ),

                  ProfileStat(
                    icon: Icon(
                      Icons.thumb_up_off_alt_outlined,
                      size: 38,
                      color: Colors.grey[200],
                    ),
                    statisticName: 'Likes',
                    statisticValue: 0,
                  )
                ],
              )
            ],
          ),
        ),

        // profile actions
        Container(
          // color: Colors.yellow,
          // 116 is the sum of the default height of the botnavbar + the icon thing ig
          height: MediaQuery.of(context).size.height / 2 - 116,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                SizedBox(height: 10),

                // edit profile action
                ProfileActionTile(
                  actionTitle: 'Edit Profile',
                  actionIcon: Icon(Icons.edit),
                ),

                // settings action
                ProfileActionTile(
                  actionTitle: 'Settings',
                  actionIcon: Icon(Icons.settings),
                ),

                Divider(),

                // log out action
                ProfileActionTile(
                  actionTitle: 'Log Out',
                  actionIcon: Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
