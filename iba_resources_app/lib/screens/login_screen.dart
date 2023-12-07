import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/buttons/provider_auth_button.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  final _loginFormKey = GlobalKey<FormState>();

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

  void _handleSignInPressed() {
    BlocProvider.of<SignInBloc>(context).add(
      SignInSubmittedEvent(email, password),
    );
  }

  void _signInWithGoogle() {
    BlocProvider.of<SignInBloc>(context).add(SignInWithGoogleEvent());
  }

  void _signInWithFacebook() {
    BlocProvider.of<SignInBloc>(context).add(SignInWithFacebookEvent());
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
            const SizedBox(height: 90),

            // welcome back
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // Jinnah quote
            const Text(
              'Parhoge likhoge, banoge nawaab - Jinnah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 20),

            // login form
            Form(
              key: _loginFormKey,
              child: BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInInErrorState) {
                    showSnackbar(state.errorMessage!);
                  }

                  if (state is SignInValidState) {
                    NavigationService.routeToReplacementNamed('/layout');
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      // email input
                      EmailTextFormField(
                        helperLabel: 'Enter email address',
                        leadingIcon: Icons.email_outlined,
                        setEmail: (String enteredEmail) {
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

                      //login button
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FilledButton(
                          onPressed: () {
                            if (_loginFormKey.currentState!.validate()) {
                              _handleSignInPressed();
                            }
                          },
                          style: Theme.of(context).filledButtonTheme.style,
                          child: (state is SignInLoadingState)
                              ? const ButtonProgressIndicator()
                              : const Text(
                                  'LOGIN',
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

                      // google sign in btn
                      AuthProviderButton(
                        imageSrc: 'assets/google-logo.png',
                        buttonLabel: 'Sign in with Google',
                        onTap: _signInWithGoogle,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),

                      const SizedBox(height: 10),

                      // facebook sign in btn
                      AuthProviderButton(
                        imageSrc: 'assets/facebook-logo.png',
                        buttonLabel: 'Sign in with FaceBook',
                        onTap: _signInWithFacebook,
                        backgroundColor: const Color(0XFF448AFF),
                      ),

                      const SizedBox(height: 20),

                      // buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                NavigationService.routeToNamed("/resetpass"),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
