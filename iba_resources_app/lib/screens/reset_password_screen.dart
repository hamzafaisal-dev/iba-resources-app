import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

final _firebase = FirebaseAuth.instance;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  final _resetPassFormKey = GlobalKey<FormState>();

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

  Future<void> sendSignInLink() async {
    try {
      if (_resetPassFormKey.currentState!.validate()) {
        await _firebase.sendPasswordResetEmail(
          email: _emailController.text,
          actionCodeSettings: ActionCodeSettings(
            url: "https://outlook.office365.com/",
            handleCodeInApp: true,
          ),
        );

        if (context.mounted) {
          showSnackbar('Password reset link sent to ${_emailController.text}');

          _emailController.clear();

          Navigator.of(context).pushNamed("/login");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "auth/invalid-email") {
        showSnackbar('Invalid email');
      } else if (e.code == "auth/user-not-found") {
        showSnackbar('user not found');
      }
    } catch (error) {
      showSnackbar(error.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              'PA\nSS',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),

            const Text(
              'RESET',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Align(
              child: Text(
                'A password reset link will be sent to the entered email',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            Form(
              key: _resetPassFormKey,
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

                  //next button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: sendSignInLink,
                      style: customButtonStyle,
                      child: const Text(
                        'NEXT',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
