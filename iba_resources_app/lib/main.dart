import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/core/resource/network.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';

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

  final AuthRepository authRepository = AuthRepository(
    userFirebaseClient: UserFirebaseClient(
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance),
  );

  final ResourceRepository resourceRepository = ResourceRepository(
    resourceFirestoreClient: ResourceFirestoreClient(
      firestore: FirebaseFirestore.instance,
      firebaseStorage: FirebaseStorage.instance,
    ),
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      resourceRepository: resourceRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.resourceRepository,
  });

  final AuthRepository authRepository;
  final ResourceRepository resourceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) {
            return AuthBloc(authRepository: authRepository);
          },
        ),
        BlocProvider<SignInBloc>(
          create: (BuildContext context) {
            return SignInBloc(authRepository: authRepository);
          },
        ),
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) {
            return SignUpBloc(authRepository: authRepository);
          },
        ),
        BlocProvider<ResourceBloc>(
          create: (BuildContext context) {
            return ResourceBloc(resourceRepository: resourceRepository);
          },
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
