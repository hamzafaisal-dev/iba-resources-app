import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iba_resources_app/models/resource.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Resource>> allResources;

  Future<List<Resource>> getAllResources() async {
    try {
      final fireStoreInstance = FirebaseFirestore.instance;

      final resources = await fireStoreInstance.collection('resources').get();

      List<Resource> allFetchedResources = resources.docs.map((docSnapshot) {
        return Resource.fromJson(docSnapshot.data());
      }).toList();

      return allFetchedResources;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  void initState() {
    allResources = getAllResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: allResources,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Masla hogaya bhau');
        }

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var resourceObject = snapshot.data![index];

              return Card(
                child: ListTile(
                  title: Text(resourceObject.resourceTitle),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                  ),
                ),
              );
            },
          );
        }

        return const Text('Loading...');
      },
    ));
  }
}
