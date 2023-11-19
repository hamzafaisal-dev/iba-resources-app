import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/screens/login_screen.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSigningUp = false;
  bool _passwordHidden = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  Future<void> handleSignUp() async {
    try {
      if (_signUpFormKey.currentState!.validate()) {
        setState(() {
          _isSigningUp = true;
        });

        final newUserCredentials =
            await _firebase.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUserCredentials.user!.uid)
            .set(
          {
            "name": _nameController.text,
            "email": _emailController.text,
          },
        ).then((value) {
          setState(() {
            _isSigningUp = false;
          });

          Navigator.of(context).pushReplacementNamed('/home');
        });

        // _nameController.clear();
        // _emailController.clear();
        // _passwordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSigningUp = false;
      });
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showSnackbar('INVALID_LOGIN_CREDENTIALS');
      } else if (e.code == 'invalid-email') {
        showSnackbar('Invalid email');
      } else if (e.code == 'wrong-password') {
        showSnackbar('Wrong password');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar('Email already in use');
      } else {
        showSnackbar('Error: ${e.message}');
      }
    } catch (error) {
      _isSigningUp = false;
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
    _nameController.dispose();
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
                  TextFormField(
                    decoration: textFormFieldDecoration(
                      'Enter name',
                      const Icon(
                        Icons.person_outline_sharp,
                      ),
                      null,
                    ),
                    cursorColor: Colors.black,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 3) {
                        return 'Name cannot be less than 3 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

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
                    obscureText: _passwordHidden,
                    controller: _passwordController,
                    cursorColor: Colors.black,
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

                  //sign up button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: handleSignUp,
                      style: customButtonStyle,
                      child: _isSigningUp
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'SIGN UP',
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

                  // google sign up btn
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
                            'Sign-up with Google',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Login',
                          style:
                              const TextStyle(fontSize: 15, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/login');
                            },
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
