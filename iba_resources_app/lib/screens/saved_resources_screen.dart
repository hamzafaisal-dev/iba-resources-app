import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';

class SavedResourcesScreen extends StatefulWidget {
  const SavedResourcesScreen({super.key});

  @override
  State<SavedResourcesScreen> createState() => _SavedResourcesScreenState();
}

class _SavedResourcesScreenState extends State<SavedResourcesScreen> {
  late final List<String> usersSavedResources;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateAuthenticated) {
          if (state.authenticatedUser.savedResources != null) {
            usersSavedResources = state.authenticatedUser.savedResources!;
          }
        }

        return Center(
          child: ListView.builder(
            itemCount: usersSavedResources.length,
            itemBuilder: (context, index) {
              final String savedResource = usersSavedResources[index];

              return Card(
                child: ListTile(
                  title: Text(savedResource),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
