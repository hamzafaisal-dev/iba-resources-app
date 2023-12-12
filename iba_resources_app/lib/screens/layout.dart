import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/notifications_screen.dart';
import 'package:iba_resources_app/screens/saved_resources_screen.dart';
import 'package:iba_resources_app/constants/icons.dart' as constants;
import 'package:iba_resources_app/screens/user_screen.dart';
import 'package:iba_resources_app/services/navigation_service.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.resourceRepository});

  final ResourceRepository resourceRepository;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ResourceRepository resourceRepository = widget.resourceRepository;

    // shows dynamic screen content based on btotom navbar index
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateUnauthenticated) {
                NavigationService.routeToReplacementNamed('/login');
              }
            },
            child: HomeScreen(resourceRepository: resourceRepository),
          );
          break;
        case 1:
          widget = const SavedResourcesScreen();
          break;
        case 2:
          widget = const AddResourceScreen();
          break;
        case 3:
          widget = const NotificationsScreen();
          break;
        case 4:
          widget = const UserScreen();
          break;
        default:
          widget = const ErrorScreen();
          break;
      }
      return widget;
    }

    AppBar getAppbar() {
      String title;

      switch (currentIndex) {
        case 0:
          title = 'Home';
        case 1:
          title = 'Saved Resources';
        case 2:
          title = 'Add Resource';
        case 3:
          title = 'Notifications';
        case 4:
          title = 'Profile';
        default:
          title = 'IBARA';
      }

      return AppBar(
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      );
    }

    return Scaffold(
      appBar: getAppbar(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: const Color(0XFFF3F3F3),
        animationDuration: const Duration(milliseconds: 300),
        index: currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        items: constants.ConstantIcons.bottomNavBarIcons,
      ),
      body: getContent(currentIndex),
    );
  }
}
