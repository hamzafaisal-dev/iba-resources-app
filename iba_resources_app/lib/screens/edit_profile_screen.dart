import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/name_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel? _authenticatedUser;

  String userName = '';

  final _editProfileFormKey = GlobalKey<FormState>();

  void _handleEditProfile(UserModel authenticatedUser) {
    if (_editProfileFormKey.currentState!.validate()) {
      print(authenticatedUser.name);

      final updatedUser = authenticatedUser.copyWith(name: userName);

      BlocProvider.of<UserBloc>(context).add(
        UserUpdateEvent(updatedUser, userName),
      );
    }
  }

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

  @override
  void initState() {
    // access the auth blok using the context
    final authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _editProfileFormKey,
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserUpdateError) {
                showSnackbar(state.errorMessage);
              }

              if (state is UserUpdateSuccess) {
                showSnackbar('User details updated successfully');
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  // userName input
                  if (_authenticatedUser != null)
                    NameFormField(
                      helperLabel: _authenticatedUser!.name,
                      leadingIcon: Icons.person_outline_sharp,
                      setName: (enteredName) {
                        userName = enteredName;
                      },
                    ),

                  const SizedBox(height: 20),

                  if (_authenticatedUser != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        onPressed: () {
                          _handleEditProfile(_authenticatedUser!);
                        },
                        style: Theme.of(context).filledButtonTheme.style,
                        child: (state is UserLoadingState)
                            ? const ButtonProgressIndicator()
                            : const Text(
                                'SAVE',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
