import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/saved_resource_tile.dart';
import 'package:lottie/lottie.dart';

class SavedResourcesScreen extends StatefulWidget {
  const SavedResourcesScreen({super.key});

  @override
  State<SavedResourcesScreen> createState() => _SavedResourcesScreenState();
}

class _SavedResourcesScreenState extends State<SavedResourcesScreen> {
  late List<ResourceModel> usersSavedResources;
  late UserModel _authenticatedUser;
  ResourceModel? currentResource;

  @override
  void initState() {
    print('initState called');
    // access the auth blok using the context
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;

      if (_authenticatedUser.savedResources != null) {
        // if (currentResource != null) {
        //   print('ye hai bhai iss mein');
        // }

        // print(currentResource!.resourceTitle);

        usersSavedResources = _authenticatedUser.savedResources!;
      }
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies called');

// this method is called every time the dependencies of the widget change,
    // which includes when the screen is first created and every time it's displayed.

    // can add any logic that needs to be executed when the screen is displayed here.

    if (_authenticatedUser.savedResources != null) {
      if (currentResource != null) {
        print('ye hai bhai iss mein');
      }

      // print(currentResource!.resourceTitle);

      // usersSavedResources = _authenticatedUser.savedResources!;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // if (state is AuthStateAuthenticated) {
          //   if (state.authenticatedUser.savedResources != null) {
          //     usersSavedResources = state.authenticatedUser.savedResources!;
          //   }
          // }

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

                return SavedResourceTile(
                  onTap: () async {
                    final returnedData = await Navigator.pushNamed(
                      context,
                      '/viewResourceDetails',
                      arguments: {'resourceObject': savedResource},
                    );

                    if (returnedData != null) {
                      currentResource = returnedData as ResourceModel;
                    }
                  },
                  title: savedResource.resourceTitle,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
