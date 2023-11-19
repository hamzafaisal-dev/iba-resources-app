import 'package:flutter/material.dart';

class ContributionsScreen extends StatelessWidget {
  const ContributionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contributions'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Contributions Screen'),
      ),
    );
  }
}
