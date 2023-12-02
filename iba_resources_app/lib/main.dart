import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/landing_screen.dart';
import 'package:iba_resources_app/route_generator.dart';
import 'package:iba_resources_app/services/navigation_service.dart';

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
      onGenerateRoute: RouteGenerator.generateRoutes,
      navigatorKey: NavigationService.navigatorKey,
      home: const LandingScreen(),
    );
  }
}
