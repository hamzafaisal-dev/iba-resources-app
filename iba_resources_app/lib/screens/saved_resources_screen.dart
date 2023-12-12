import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:lottie/lottie.dart';

class SavedResourcesScreen extends StatefulWidget {
  const SavedResourcesScreen({super.key});

  @override
  State<SavedResourcesScreen> createState() => _SavedResourcesScreenState();
}

class _SavedResourcesScreenState extends State<SavedResourcesScreen> {
  late List<ResourceModel> usersSavedResources;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateAuthenticated) {
          if (state.authenticatedUser.savedResources != null) {
            usersSavedResources = state.authenticatedUser.savedResources!;
          }
        }

        if (usersSavedResources.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You have no resources saved',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Lottie.asset(
                  'assets/EmptyGhostAnimation.json',
                  repeat: false,
                  frameRate: FrameRate(420),
                  height: 300,
                ),
              ],
            ),
          );
        }

        return Center(
          child: ListView.builder(
            itemCount: usersSavedResources.length,
            itemBuilder: (context, index) {
              final ResourceModel savedResource = usersSavedResources[index];

              return Card(
                child: ListTile(
                  onTap: () {
                    NavigationService.routeToNamed(
                      '/viewResourceDetails',
                      arguments: {'resourceObject': savedResource},
                    );
                  },
                  title: Text(savedResource.courseName),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
