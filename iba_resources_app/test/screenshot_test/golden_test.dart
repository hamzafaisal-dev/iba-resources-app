import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/edit_profile_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/landing_screen.dart';
import 'package:iba_resources_app/screens/login_screen.dart';
import 'package:iba_resources_app/screens/add_resource_details_screen.dart';
import 'package:iba_resources_app/screens/notifications_screen.dart';
import 'package:iba_resources_app/screens/otp_screen.dart';
import 'package:iba_resources_app/screens/reset_password_screen.dart';
import 'package:iba_resources_app/screens/rewards_screen.dart';
import 'package:iba_resources_app/screens/saved_resources_screen.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens("Login", (tester) async {
    const widget = MaterialApp(home: LoginScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'Login Screenshot');
  });
  testGoldens("AddResourceDetailsScreen", (tester) async {
    const widget = MaterialApp(home: AddResourceDetailsScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'AddResourceDetailsScreen Screenshot');
  });
  testGoldens("AddResourceScreen", (tester) async {
    const widget = MaterialApp(home: AddResourceScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'AddResourceScreen Screenshot');
  });
  testGoldens("EditProfileScreen", (tester) async {
    const widget = MaterialApp(home: EditProfileScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'EditProfileScreen Screenshot');
  });
  testGoldens("ErrorScreen", (tester) async {
    const widget = MaterialApp(home: ErrorScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'ErrorScreen Screenshot');
  });
  testGoldens("LandingScreen", (tester) async {
    const widget = MaterialApp(home: LandingScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'LandingScreen Screenshot');
  });
  testGoldens("NotificationsScreen", (tester) async {
    const widget = MaterialApp(home: NotificationsScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'NotificationsScreen Screenshot');
  });
  // testGoldens("OTPScreen", (tester) async {
  //   const widget = MaterialApp(home: OTPScreen());
  //   await tester.pumpWidgetBuilder(
  //     widget,
  //     surfaceSize: const Size(500, 1000),
  //   );
  //   await screenMatchesGolden(tester, 'OTPScreen Screenshot');
  // });
  testGoldens("ResetPasswordScreen", (tester) async {
    const widget = MaterialApp(home: ResetPasswordScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'ResetPasswordScreen Screenshot');
  });
  testGoldens("RewardsScreen", (tester) async {
    const widget = MaterialApp(home: RewardsScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'RewardsScreen Screenshot');
  });
  testGoldens("SavedResourcesScreen", (tester) async {
    const widget = MaterialApp(home: SavedResourcesScreen());
    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );
    await screenMatchesGolden(tester, 'SavedResourcesScreen Screenshot');
  });
}
