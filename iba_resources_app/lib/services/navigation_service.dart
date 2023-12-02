import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static dynamic routeToNamed(String route, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  }

  static dynamic routeToReplacementNamed(String route, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  static dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
