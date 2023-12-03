import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iba_resources_app/services/navigation_service.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () {
        NavigationService.routeToReplacementNamed('/landing');
      },
    );
  }
}
