import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iba_resources_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';
import 'package:iba_resources_app/widgets/buttons/provider_auth_button.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/name_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = '';
  String email = '';
  String password = '';

  final _signUpFormKey = GlobalKey<FormState>();

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

  void handleSignUp() {
    BlocProvider.of<SignUpBloc>(context).add(
      SignUpSubmittedEvent(name, email, password),
    );
  }

  void _signUpWithGoogle() {
    BlocProvider.of<SignUpBloc>(context).add(SignUpWithGoogleEvent());
  }

  void _signInWithFacebook() {
    BlocProvider.of<SignUpBloc>(context).add(SignUpWithFacebookEvent());
  }

  @override
  void dispose() {
    BlocProvider.of<SignUpBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF3F3F3),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            //
            const SizedBox(height: 95),

            const Text(
              'Get On Board!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Create your profile to start your journey',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 20),

            Form(
              key: _signUpFormKey,
              child: BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpValidState) {
                    NavigationService.routeToReplacementNamed('/layout');
                  } else if (state is SignUpErrorState) {
                    showSnackbar(state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // name input
                      NameFormField(
                        helperLabel: 'Enter name',
                        leadingIcon: Icons.person_outline_sharp,
                        setName: (enteredName) {
                          name = enteredName;
                        },
                      ),

                      const SizedBox(height: 20),

                      // email input
                      EmailTextFormField(
                        helperLabel: 'Enter email address',
                        leadingIcon: Icons.email_outlined,
                        setEmail: (enteredEmail) {
                          email = enteredEmail;
                        },
                      ),

                      const SizedBox(height: 20),

                      // password input
                      PasswordFormField(
                        helperLabel: 'Enter password',
                        leadingIcon: Icons.lock_outline,
                        setPassword: (enteredPassword) {
                          password = enteredPassword;
                        },
                      ),

                      const SizedBox(height: 20),

                      //sign up button
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FilledButton(
                          onPressed: state is SignUpLoadingState
                              ? null
                              : () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    handleSignUp();
                                  }
                                },
                          style: Theme.of(context).filledButtonTheme.style,
                          child: state is SignUpLoadingState
                              ? const ButtonProgressIndicator()
                              : const Text(
                                  'SIGN UP',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      //divider
                      const NamedDivider(
                        dividerText: 'OR',
                        dividerColor: Colors.grey,
                      ),

                      const SizedBox(height: 20),

                      // google sign up btn
                      AuthProviderButton(
                        imageSrc: 'assets/google-logo.png',
                        buttonLabel: 'Continue with Google',
                        onTap: () {
                          _signUpWithGoogle();
                        },
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),

                      const SizedBox(height: 20),

                      // facebook sign in btn
                      AuthProviderButton(
                        imageSrc: 'assets/facebook-logo.png',
                        buttonLabel: 'Continue with FaceBook',
                        onTap: () {
                          _signInWithFacebook();
                        },
                        backgroundColor: const Color(0XFF448AFF),
                      ),

                      const SizedBox(height: 20),

                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Already have an account? ',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/login');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
