import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/screens/home_screen_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.resourceRepository});

  final ResourceRepository resourceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResourceBloc(resourceRepository: resourceRepository),
      child: HomeScreenLayout(resourceRepository: resourceRepository),
    );
  }
}
