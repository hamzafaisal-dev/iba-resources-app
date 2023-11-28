import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConstantIcons {
  static const bottomNavBarIcons = [
    Icon(
      Icons.home,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.bookmark,
      color: Colors.white,
      size: 28,
    ),
    Icon(
      Icons.post_add,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.notifications,
      color: Colors.white,
      size: 29,
    ),
    Icon(
      Icons.person,
      color: Colors.white,
      size: 30,
    ),
  ];
}

class HomeScreenIcons {
  static Widget thumbsUp = const FaIcon(
    FontAwesomeIcons.thumbsUp,
    size: 18,
  );

  static Widget thumbsDown = Transform(
    alignment: Alignment.center,
    transform: Matrix4.rotationY(3.14),
    child: const FaIcon(
      FontAwesomeIcons.thumbsDown,
      size: 18,
    ),
  );
}
