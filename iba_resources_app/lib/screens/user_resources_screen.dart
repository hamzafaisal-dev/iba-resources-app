import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/saved_resource_tile.dart';
import 'package:lottie/lottie.dart';

class UserResourcesScreen extends StatefulWidget {
  const UserResourcesScreen({super.key});

  @override
  State<UserResourcesScreen> createState() => _UserResourcesScreenState();
}

class _UserResourcesScreenState extends State<UserResourcesScreen> {
  late List<ResourceModel> usersPostedResources;
  late UserModel _authenticatedUser;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _deleteResource(String resourceId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: BlocListener<ResourceBloc, ResourceState>(
            listener: (context, state) {
              if (state is ResourceBookmarkSuccess) {
                Navigator.of(context).pop();

                showSnackbar('Resource deleted succesfully');
              } else if (state is ResourceError) {
                showSnackbar(state.errorMsg);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                const Text(
                  'Are you sure you want to delete this resource? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.9,
                      child: FilledButton(
                        onPressed: () {
                          BlocProvider.of<ResourceBloc>(context).add(
                            DeleteResourceEvent(
                              resourceId: resourceId,
                              user: _authenticatedUser,
                            ),
                          );
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.9,
                      child: FilledButton(
                        style: ButtonStyles.filledButtonStyle.copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // access the auth blok using the context
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;

      if (_authenticatedUser.postedResources != null) {
        usersPostedResources = _authenticatedUser.postedResources!;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Uploaded Resources'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (usersPostedResources.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'You haven\'t posted any resources yet',
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
                itemCount: usersPostedResources.length,
                itemBuilder: (context, index) {
                  final ResourceModel postedResource =
                      usersPostedResources[index];

                  return SavedResourceTile(
                    onTap: () async {
                      Navigator.pushNamed(
                        context,
                        '/viewResourceDetails',
                        arguments: {'resourceObject': postedResource},
                      );
                    },
                    title: postedResource.resourceTitle,
                    trailing: CircleAvatar(
                      radius: 19,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      child: InkWell(
                        onTap: () => _deleteResource(postedResource.resourceId),
                        child: Icon(
                          Icons.delete_forever,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 26,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      // body: ,
    );
  }
}
