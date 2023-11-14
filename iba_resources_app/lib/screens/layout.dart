import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/user_profile_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = const HomeScreen();
          break;
        case 1:
          widget = const AddResourceScreen();
          break;
        case 2:
          widget = const AddResourceScreen();
          break;
        case 3:
          widget = const UserProfileScreen();
          break;
        default:
          widget = const HomeScreen();
          break;
      }
      return widget;
    }

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 253, 127, 118),
        backgroundColor: Colors.white,
        // buttonBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        index: currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.book,
            color: Colors.white,
            size: 28,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      body: getContent(currentIndex),
    );
  }
}
