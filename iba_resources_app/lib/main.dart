import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/constants/icons.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/add_resource_details_screen.dart';
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
        //
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XFFFF7B66),
          primary: const Color(0XFFFF7B66),
          primaryContainer: const Color(0XFFFFF1F1),
          secondary: const Color(0XFF01D2AF),
          secondaryContainer: const Color(0XFFE6FAF8),
          tertiary: Colors.grey,
          error: const Color(0XFFB41528),
        ),

        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Color(0XFFF2F6F7),
          elevation: 0,
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyles.filledButtonStyle,
        ),

        scaffoldBackgroundColor: const Color(0XFFF2F6F7),

        textTheme: GoogleFonts.urbanistTextTheme(),
      ),
      initialRoute: "/landing",
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
        "/resourceDetails": (context) => const AddResourceDetailsScreen(),
        "/notifications": (context) => const NotificationsScreen(),
        "/contributions": (context) => const RewardsScreen(),
        "/error": (context) => const ErrorScreen(),
      },
    );
  }
}
