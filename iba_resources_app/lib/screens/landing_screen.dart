import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final ButtonStyle customButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
  ),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    const EdgeInsets.symmetric(vertical: 12.0),
  ),
);

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.primary, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //
            Lottie.asset(
              'assets/AuthAnimation.json',
              repeat: false,
              frameRate: FrameRate(420),
            ),

            const SizedBox(height: 30),

            const Text(
              'Welcome to IBARA',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Find all IBA study resources in one place!',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // login button
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: customButtonStyle,
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  // signup button
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      style: customButtonStyle,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
