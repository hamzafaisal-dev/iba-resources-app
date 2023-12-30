// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hexagon/hexagon.dart';
// import 'package:iba_resources_app/services/navigation_service.dart';
// import 'package:iba_resources_app/widgets/buttons/custom_filled_button.dart';
// import 'package:iba_resources_app/widgets/profile/profile_action_tile.dart';
// import 'package:iba_resources_app/widgets/profile/profile_stat.dart';

// final _firebaseAuth = FirebaseAuth.instance;

// class UserProfileScreen extends StatefulWidget {
//   const UserProfileScreen({super.key});

//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }

// class _UserProfileScreenState extends State<UserProfileScreen> {
//   bool loading = false;

//   void logOut() {
//     setState(() {
//       loading = true;
//     });

//     _firebaseAuth.signOut().then(
//       (value) {
//         setState(() {
//           loading = false;
//         });
//         NavigationService.routeToReplacementNamed('/login');
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // profile details
//         Container(
//           height: MediaQuery.of(context).size.height / 2.52,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.primary,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               //
//               const SizedBox(height: 18),

//               // pfp + name
//               Row(
//                 children: [
//                   const SizedBox(width: 32),

//                   // user pfp
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundColor: const Color.fromARGB(255, 240, 99, 89),
//                     child: Icon(
//                       Icons.person,
//                       size: 90,
//                       color: Colors.grey[200],
//                     ),
//                   ),

//                   const SizedBox(width: 35),

//                   // user name + contributions button
//                   SizedBox(
//                     child: Column(
//                       children: [
//                         // user name
//                         Text(
//                           'Farhan Mushi',
//                           style: TextStyle(
//                             fontSize: 28,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             shadows: [
//                               Shadow(
//                                 offset: const Offset(
//                                   2.0,
//                                   2.5,
//                                 ),
//                                 blurRadius: 2.0,
//                                 color: Colors.black.withOpacity(
//                                   0.2,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 5),

//                         // my contributions button
//                         CustomFilledButton(
//                           buttonLabel: 'My Contributions',
//                           fontSize: 18,
//                           borderRadius: 10,
//                           paddingX: 20,
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color.fromARGB(255, 240, 99, 89),
//                           ),
//                           onTap: () =>
//                               NavigationService.routeToNamed('/contributions'),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),

//               // divider
//               Container(
//                 height: 25,
//                 margin: const EdgeInsets.fromLTRB(0, 17, 0, 13),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   image: const DecorationImage(
//                     image: AssetImage('assets/bank-note.png'),
//                     repeat: ImageRepeat.repeat,
//                     opacity: 0.1,
//                   ),
//                 ),
//               ),

//               // profile stats
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //
//                   ProfileStat(
//                     icon: Icon(
//                       Icons.star,
//                       size: 40,
//                       color: Colors.grey[200],
//                     ),
//                     statisticName: 'Points',
//                     statisticValue: 26,
//                   ),

//                   ProfileStat(
//                     icon: Icon(
//                       Icons.group,
//                       size: 38,
//                       color: Colors.grey[200],
//                     ),
//                     statisticName: 'Contributions',
//                     statisticValue: 9,
//                   ),

//                   ProfileStat(
//                     icon: Icon(
//                       Icons.thumb_up_off_alt_outlined,
//                       size: 38,
//                       color: Colors.grey[200],
//                     ),
//                     statisticName: 'Likes',
//                     statisticValue: 0,
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),

//         // profile actions
//         SizedBox(
//           // 116 is the sum of the default height of the botnavbar + the icon ig
//           height: MediaQuery.of(context).size.height / 2 - 116,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 //
//                 const SizedBox(height: 10),

//                 // edit profile action
//                 const ProfileActionTile(
//                   actionTitle: 'Edit Profile',
//                   actionIcon: Icon(Icons.edit),
//                 ),

//                 // settings action
//                 const ProfileActionTile(
//                   actionTitle: 'Settings',
//                   actionIcon: Icon(Icons.settings),
//                 ),

//                 const Divider(),

//                 // log out action
//                 ProfileActionTile(
//                   actionTitle: 'Log Out',
//                   actionIcon: const Icon(Icons.logout),
//                   tilePressed: logOut,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
