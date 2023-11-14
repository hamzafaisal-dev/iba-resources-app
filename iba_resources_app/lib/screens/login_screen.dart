import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final _firebase = FirebaseAuth.instance;

final ButtonStyle customButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
  ),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    const EdgeInsets.symmetric(vertical: 18.0),
  ),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;
  bool _passwordHidden = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: const Color.fromARGB(255, 253, 127, 118),
      ),
    );
  }

  Future<void> handleLogin() async {
    try {
      if (_loginFormKey.currentState!.validate()) {
        setState(() {
          _isLoggingIn = true;
        });

        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredentials.user != null) {
          setState(() {
            _isLoggingIn = false;
          });

          showSnackbar(userCredentials.user!.email.toString());

          Navigator.of(context).pushReplacementNamed('/layout');
        }

        _emailController.clear();
        _passwordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoggingIn = false;
      });
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showSnackbar('Invalid login credentials');
      } else if (e.code == 'invalid-email') {
        showSnackbar('Invalid email');
      } else if (e.code == 'wrong-password') {
        showSnackbar('Wrong password');
      } else {
        showSnackbar('Error: ${e.message}');
      }
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

  InputDecoration textFormFieldDecoration(
    String labelText,
    Widget prefixIcon,
    Widget? suffixIcon,
  ) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.grey,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.black,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.red,
        ),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.black,
      ),
      prefixIcon: prefixIcon,
      labelText: labelText,
      suffixIcon: suffixIcon,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            //
            const SizedBox(height: 90),

            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

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
                  TextFormField(
                    decoration: textFormFieldDecoration(
                      'Enter email address',
                      const Icon(
                        Icons.email_outlined,
                      ),
                      null,
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@khi.iba.edu.pk') ||
                          value.trim().length < 20) {
                        return 'Enter a valid IBA email address';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // password input
                  TextFormField(
                    decoration: textFormFieldDecoration(
                      "Enter password",
                      const Icon(
                        Icons.lock_outline,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordHidden = !_passwordHidden;
                          });
                        },
                        icon: _passwordHidden
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                    cursorColor: Colors.black,
                    obscureText: _passwordHidden,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 6) {
                        return 'Password should contain at least 6 characters ';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  //login button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: handleLogin,
                      style: customButtonStyle,
                      child: _isLoggingIn
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 253, 127, 118),
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //divider
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // google sign in btn
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: signInWithGoogle,
                      style: customButtonStyle.copyWith(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google-logo.png',
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // facebook sign in btn
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: signInWithFacebook,
                      style: customButtonStyle.copyWith(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0XFF448AFF),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/facebook-logo.png',
                            width: 26.5,
                            height: 26.5,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign in with FaceBook',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // twitter sign in btn
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: () {},
                      style: customButtonStyle.copyWith(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0XFF42464C),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/twitter-logo.png',
                            width: 26.5,
                            height: 26.5,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign in with X',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
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
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
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
                            Navigator.of(context).pushNamed("/resetpass"),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
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
