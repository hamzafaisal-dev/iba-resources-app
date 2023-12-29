import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/reward/rewards_bloc.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/core/auth/auth_repository/auth_repository.dart';
import 'package:iba_resources_app/core/auth/network.dart';
import 'package:iba_resources_app/core/resource/network.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/core/rewards/rewards_network.dart';
import 'package:iba_resources_app/core/rewards/rewards_repository.dart';
import 'package:iba_resources_app/core/user/network.dart';
import 'package:iba_resources_app/core/user/user_repository.dart';
import 'package:iba_resources_app/firebase_options.dart';
import 'package:iba_resources_app/screens/login_screen.dart';
import 'package:iba_resources_app/widgets/buttons/provider_auth_button.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/email_text_form_field.dart';
import 'package:iba_resources_app/widgets/textfields/auth_fields/password_form_field.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  group('Login Screen Widget Test', () {
    // late MockSignInBloc mockSignInBloc;
    late AuthRepository authRepository;
    late ResourceRepository resourceRepository;
    late UserRepository userRepository;
    late RewardRepository rewardRepository;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      TestWidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // mockSignInBloc = MockSignInBloc();
      authRepository = AuthRepository(
        userFirebaseClient: UserFirebaseClient(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
        ),
      );

      resourceRepository = ResourceRepository(
        resourceFirestoreClient: ResourceFirestoreClient(
          firestore: FirebaseFirestore.instance,
          firebaseStorage: FirebaseStorage.instance,
        ),
      );

      userRepository = UserRepository(
        userFirestoreClient: UserFirestoreClient(
          firebaseFirestore: FirebaseFirestore.instance,
        ),
      );

      rewardRepository = RewardRepository(
        rewardsFirestoreClient: RewardFirestoreClient(
          firestore: FirebaseFirestore.instance,
        ),
      );
    });

    testWidgets('renders login screen widgets', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
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
                return ResourceBloc(
                  resourceRepository: resourceRepository,
                  authBloc: BlocProvider.of<AuthBloc>(context),
                );
              },
            ),
            BlocProvider<UserBloc>(
              create: (BuildContext context) {
                return UserBloc(
                  userRepository: userRepository,
                  authBloc: BlocProvider.of<AuthBloc>(context),
                );
              },
            ),
            BlocProvider<RewardsBloc>(
              create: (BuildContext context) {
                return RewardsBloc(
                  rewardRepository: rewardRepository,
                );
              },
            ),
          ],
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // expect(find.byType(Text), findsNWidgets(3));
      // expect(find.byType(Form), findsOneWidget);
      // expect(find.byType(EmailTextFormField), findsOneWidget);
      // expect(find.byType(PasswordFormField), findsOneWidget);
      // expect(find.byType(FilledButton), findsOneWidget);
      // expect(find.byType(NamedDivider), findsOneWidget);
      // expect(find.byType(AuthProviderButton), findsNWidgets(2));
      expect(find.byType(RichText), findsOneWidget);
      // expect(find.byType(InkWell), findsOneWidget);
      // expect(find.byType(Row), findsOneWidget);
    });

    // testWidgets('navigates to sign up screen', (tester) async {
    //   await tester.pumpWidget(
    //     const MaterialApp(
    //       home: LoginScreen(),
    //     ),
    //   );

    //   await tester.tap(find.text('Sign Up'));
    //   await tester.pumpAndSettle();

    //   // verify(mockSignInBloc.add(any)); // Replace with your actual SignInBloc logic
    //   // expect(find.byType(SignUpScreen), findsOneWidget);
    // });

    // testWidgets('navigates to reset password screen', (tester) async {
    //   await tester.pumpWidget(
    //     const MaterialApp(
    //       home: LoginScreen(),
    //     ),
    //   );

    //   await tester.tap(find.text('Forgot Password?'));
    //   await tester.pumpAndSettle();

    //   // verify(mockSignInBloc.add(any)); // Replace with your actual SignInBloc logic
    //   // expect(find.byType(ResetPasswordScreen), findsOneWidget); // Replace with your actual ResetPasswordScreen
    // });
  });
}
