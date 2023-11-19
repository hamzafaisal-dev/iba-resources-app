import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/contributions_screen.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 127, 118),
          primary: const Color.fromARGB(255, 253, 127, 118),
          secondary: const Color(0XFFFFF1F1),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
      ),
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      //   primaryColor: const Theme.of(context).colorScheme.primary,
      //   useMaterial3: true,
      //   outlinedButtonTheme: OutlinedButtonThemeData(
      //     style: ButtonStyle(
      //       foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      //       side: MaterialStateProperty.all<BorderSide>(
      //         const BorderSide(color: Colors.black),
      //       ),
      //       splashFactory: NoSplash.splashFactory,
      //     ),
      //   ),
      //   filledButtonTheme: FilledButtonThemeData(
      //     style: ButtonStyle(
      //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      //       backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      //     ),
      //   ),
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      // ),
      home: const LandingScreen(),
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
        "/contributions": (context) => const ContributionsScreen(),
        "/error": (context) => const ErrorScreen(),
      },
    );
  }
}
