import 'package:flutter/material.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/screens/home_screen_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.resourceRepository});

  final ResourceRepository resourceRepository;

  @override
  Widget build(BuildContext context) {
    return HomeScreenLayout(resourceRepository: resourceRepository);
  }
}
