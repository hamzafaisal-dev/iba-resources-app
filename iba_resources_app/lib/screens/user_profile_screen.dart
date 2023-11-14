import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool loading = false;

  void signOut() {
    setState(() {
      loading = true;
    });

    _firebaseAuth.signOut().then(
          (value) => {
            setState(() {
              loading = false;
            }),
            Navigator.of(context).pushReplacementNamed('/login'),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loading
          ? const CircularProgressIndicator()
          : const Text('User Profile'),
    );
  }
}
