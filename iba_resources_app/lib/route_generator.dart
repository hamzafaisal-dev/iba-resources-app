import 'package:flutter/material.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/screens/add_resource_details_screen.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/landing_screen.dart';
import 'package:iba_resources_app/screens/layout.dart';
import 'package:iba_resources_app/screens/login_screen.dart';
import 'package:iba_resources_app/screens/notifications_screen.dart';
import 'package:iba_resources_app/screens/otp_screen.dart';
import 'package:iba_resources_app/screens/reset_password_screen.dart';
import 'package:iba_resources_app/screens/rewards_screen.dart';
import 'package:iba_resources_app/screens/saved_resources_screen.dart';
import 'package:iba_resources_app/screens/signup_screen.dart';
import 'package:iba_resources_app/screens/user_profile_screen.dart';
import 'package:iba_resources_app/screens/view_resource_details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/layout':
        return MaterialPageRoute(builder: (context) => const Layout());
      case '/landing':
        return MaterialPageRoute(builder: (context) => const LandingScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case '/resetpass':
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen());
      case '/otp':
        return MaterialPageRoute(builder: (context) => const OTPScreen());
      case '/profile':
        return MaterialPageRoute(
            builder: (context) => const UserProfileScreen());
      case '/saved':
        return MaterialPageRoute(
            builder: (context) => const SavedResourcesScreen());
      case '/resource':
        return MaterialPageRoute(
            builder: (context) => const AddResourceScreen());
      case '/resourceDetails':
        {
          // extracts the arguments from the current AddResourceScreen settings and cast them as a Map.
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) =>
                AddResourceDetailsScreen(arguments: receivedArguments),
          );
        }
      case '/viewResourceDetails':
        {
          print(settings.arguments);
          Map<String, Resource>? receivedMap =
              settings.arguments as Map<String, Resource>?;

          return MaterialPageRoute(
              builder: (context) =>
                  ViewResourceDetailsScreen(resourceMap: receivedMap));
        }

      case '/notifications':
        return MaterialPageRoute(
            builder: (context) => const NotificationsScreen());
      case '/contributions':
        return MaterialPageRoute(builder: (context) => const RewardsScreen());
      case '/error':
        return MaterialPageRoute(
          builder: (context) => const ErrorScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("Not found ${settings.name}"),
            ),
          ),
        );
    }
  }
}