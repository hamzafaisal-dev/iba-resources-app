import 'package:flutter/material.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_tile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            const UserProfileTile(
              leadingIcon: Icons.dark_mode,
              leadingIconSize: 30,
              title: 'Dark Mode',
              // onTap: logOut,
            ),

            const SizedBox(height: 10),

            // edit profile tile
            UserProfileTile(
              leadingIcon: Icons.edit,
              leadingIconSize: 30,
              title: 'Edit Profile',
              onTap: () => NavigationService.routeToNamed('/editProfile'),
            ),

            const SizedBox(height: 10),

            // edit profile tile
            const UserProfileTile(
              leadingIcon: Icons.delete_forever,
              leadingIconSize: 30,
              title: 'Delete Account',
              // onTap: logOut,
            ),
          ],
        ),
      ),
    );
  }
}
