import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/name_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = '';

  final _editProfileFormKey = GlobalKey<FormState>();

  void _handleEditProfile(UserModel authenticatedUser) {
    if (_editProfileFormKey.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(
        UserUpdateEvent(authenticatedUser, name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthenticated) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: _editProfileFormKey,
                child: Column(
                  children: [
                    // name input
                    NameFormField(
                      helperLabel: state.authenticatedUser.name,
                      leadingIcon: Icons.person_outline_sharp,
                      setName: (enteredName) {
                        name = enteredName;
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        onPressed: () {
                          _handleEditProfile(state.authenticatedUser);
                        },
                        style: Theme.of(context).filledButtonTheme.style,
                        child: const Text(
                          'SAVE',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
