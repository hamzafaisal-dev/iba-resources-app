import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/screens/sign_up_screen.dart';

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

  void handleLogin() async {
    try {
      if (_loginFormKey.currentState!.validate()) {
        _isLoggingIn = true;

        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        _isLoggingIn = false;

        _emailController.clear();
        _passwordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      _isLoggingIn = false;
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
      _isLoggingIn = false;
      showSnackbar('Error: $error');
    }
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
            const SizedBox(height: 160),

            const Text(
              'Welcome Back,',
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
                        Icons.person_outline_sharp,
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
                              child: CircularProgressIndicator(),
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
                    child: OutlinedButton(
                      onPressed: () {},
                      style: customButtonStyle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google-logo.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign-In with Google',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

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
                              text: 'Sign Up!',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
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
