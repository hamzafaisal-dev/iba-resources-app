import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iba_resources_app/core/providers/firebase_providers.dart';
import 'package:iba_resources_app/features/auth/repository/auth_repository.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';
import 'package:iba_resources_app/widgets/buttons/provider_auth_button.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/name_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool _isSigningUp = false;

  String name = '';
  String email = '';
  String password = '';

  final _signUpFormKey = GlobalKey<FormState>();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  // Future<void> handleSignUp() async {
  //   try {
  //     setState(() {
  //       _isSigningUp = true;
  //     });

  //     final newUserCredentials = await _firebase.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(newUserCredentials.user!.uid)
  //         .set(
  //       {
  //         "name": name,
  //         "email": password,
  //       },
  //     ).then((value) {
  //       setState(() {
  //         _isSigningUp = false;
  //       });

  //       NavigationService.routeToReplacementNamed('/layout');
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       _isSigningUp = false;
  //     });

  //     // get error statement and display it
  //     String firebaseAuthError =
  //         FirebaseAuthExceptionErrors.getFirebaseError(e);
  //     showSnackbar(firebaseAuthError);
  //   } catch (error) {
  //     setState(() {
  //       _isSigningUp = false;
  //     });

  //     showSnackbar('Error: $error');
  //   }
  // }

  void handleSignUp(WidgetRef ref) {
    ref.read(authRepoProvider).signUp(name, email, password);
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
            const SizedBox(height: 160),

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
              child: Column(
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
                      onPressed: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          handleSignUp(ref);
                        }
                      },
                      style: Theme.of(context).filledButtonTheme.style,
                      child: _isSigningUp
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
                  const GoogleButton(
                    imageSrc: 'assets/google-logo.png',
                    buttonLabel: 'Sign in with Google',
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),

                  const SizedBox(height: 20),

                  // go to login screen button
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w900),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => NavigationService.routeToNamed('/login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
