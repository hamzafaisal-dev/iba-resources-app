import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iba_resources_app/constants/constants.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/rewards_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/landing_screen.dart';
import 'package:iba_resources_app/screens/layout.dart';
import 'package:iba_resources_app/screens/login_screen.dart';
import 'package:iba_resources_app/screens/notifications_screen.dart';
import 'package:iba_resources_app/screens/otp_screen.dart';
import 'package:iba_resources_app/screens/reset_password_screen.dart';
import 'package:iba_resources_app/screens/saved_resources_screen.dart';
import 'package:iba_resources_app/screens/signup_screen.dart';
import 'package:iba_resources_app/screens/splash_screen.dart';
import 'package:iba_resources_app/screens/user_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBARA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 127, 118),
          primary: const Color.fromARGB(255, 253, 127, 118),
          primaryContainer: const Color(0XFFFFF1F1),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyles.filledButtonStyle,
        ),
      ),
      initialRoute: "/layout",
      routes: {
        "/layout": (context) => const Layout(),
        "/landing": (context) => const LandingScreen(),
        "/home": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignUpScreen(),
        "/resetpass": (context) => const ResetPasswordScreen(),
        "/otp": (context) => const OTPScreen(),
        "/profile": (context) => const UserProfileScreen(),
        "/saved": (context) => const SavedResourcesScreen(),
        "/resource": (context) => const AddResourceScreen(),
        "/notifications": (context) => const NotificationsScreen(),
        "/contributions": (context) => const RewardsScreen(),
        "/error": (context) => const ErrorScreen(),
      },
    );
  }
}
