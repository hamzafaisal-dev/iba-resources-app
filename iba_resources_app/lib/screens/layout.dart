import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/screens/add_resource_screen.dart';
import 'package:iba_resources_app/screens/error_screen.dart';
import 'package:iba_resources_app/screens/home_screen.dart';
import 'package:iba_resources_app/screens/notifications_screen.dart';
import 'package:iba_resources_app/screens/saved_resources_screen.dart';
import 'package:iba_resources_app/screens/user_profile_screen.dart';
import 'package:iba_resources_app/constants/constants.dart' as constants;

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // shows dynamic screen content based on btotom navbar index
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = const HomeScreen();
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
          widget = const UserProfileScreen();
          break;
        default:
          widget = const HomeScreen();
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
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          title,
          style: const TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 253, 127, 118),
      );
    }

    return Scaffold(
      appBar: getAppbar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 127, 118),
              ),
              accountName: Text(
                "Farhan Mushi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              accountEmail: Text(
                "f.mushi.22971@khi.iba.edu.pk",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Color.fromARGB(255, 253, 127, 118),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text("Contact Us"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 253, 127, 118),
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        index: currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        items: constants.Constants.bottomNavBarIcons,
      ),
      body: getContent(currentIndex),
    );
  }
}
