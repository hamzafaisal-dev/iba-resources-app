import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/screens/landing_screen.dart';
import 'package:lottie/lottie.dart';

void main() {
  testWidgets('Landing screen widgets test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: LandingScreen(),
    ));

    // Verify that the Lottie animation is rendered
    expect(find.byType(Lottie), findsOneWidget);

    // Verify that the text widgets are rendered
    expect(find.text('Welcome to IBARA'), findsOneWidget);
    expect(find.text('Find all IBA study resources in one place!'),
        findsOneWidget);

    // Verify that the Log In and Sign Up buttons are rendered
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);

    // // Tap on the Log In button and verify navigation
    // debugPrint('Tapping on Log In button');
    // await tester.tap(find.text('Log In'));
    // await tester.pumpAndSettle();
    // debugPrint('After tapping on Log In button');

    // // Verify navigation
    // expect(
    //   find.byType(LoginScreen),
    //   findsOneWidget,
    // );

    // // Tap on the Sign Up button and verify navigation
    // debugPrint('Tapping on Sign Up button');
    // await tester.tap(find.text('Sign Up'));
    // await tester.pumpAndSettle();
    // debugPrint('After tapping on Sign Up button');

    // // Verify navigation
    // expect(
    //   find.byType(SignUpScreen),
    //   findsOneWidget,
    // );
  });
}
