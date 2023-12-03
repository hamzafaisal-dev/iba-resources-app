import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/utils/firebase_auth_exception_utils.dart';
import 'package:iba_resources_app/widgets/buttons/provider_auth_button.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;

  String email = '';
  String password = '';

  final _loginFormKey = GlobalKey<FormState>();

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

  Future<void> handleLogin() async {
    try {
      if (_loginFormKey.currentState!.validate()) {
        setState(() {
          _isLoggingIn = true;
        });

        await _firebase
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          setState(() {
            _isLoggingIn = false;
          });

          NavigationService.routeToReplacementNamed('/layout');
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoggingIn = false;
      });

      // get error statement and display it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(e);
      showSnackbar(firebaseAuthError);
    } catch (error) {
      setState(() {
        _isLoggingIn = false;
      });

      showSnackbar('Error: $error');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
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
              child: Column(
                children: [
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

                  //login button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: handleLogin,
                      style: Theme.of(context).filledButtonTheme.style,
                      child: _isLoggingIn
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
                    onTap: signInWithGoogle,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),

                  const SizedBox(height: 10),

                  // facebook sign in btn
                  AuthProviderButton(
                    imageSrc: 'assets/facebook-logo.png',
                    buttonLabel: 'Sign in with FaceBook',
                    onTap: signInWithFacebook,
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
