import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/cubits/brightness/brightness_cubit.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/profile/user_profile_tile.dart';

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
            // toggle brightness tile

            UserProfileTile(
              leadingIcon: Icons.dark_mode,
              leadingIconSize: 30,
              title: 'Dark Mode',
              onTap: () {
                context.read<BrightnessCubit>().toggleBrightness();
              },
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

            // delete account tile
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
