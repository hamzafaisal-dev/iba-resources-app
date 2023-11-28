import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/screens/home_screen_layout.dart';

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

      // fetches all documents in the resources collection
      final resources = await fireStoreInstance.collection('resources').get();

      // resources.docs returns a list of QueryDocumentSnapshot
      // maps over the list, converts each document into a Resource, returns list of Resources
      List<Resource> allFetchedResources = resources.docs.map((docSnapshot) {
        return Resource.fromJson(docSnapshot.data());
      }).toList();

      return allFetchedResources;
    } catch (error) {
      return [];
      // throw Exception(error.toString());
    }
  }

  void downloadResource(List<dynamic> fileDownloadUrls) async {
    // takes in list of download URLs, loops over the list, downloads each file onto phone
    for (String fileUrl in fileDownloadUrls) {
      await FileDownloader.downloadFile(
        url: fileUrl,
        onDownloadCompleted: (path) {
          // final File file = File(path);
          print('Download successful!');
        },
      );
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
          if (snapshot.data!.isEmpty) {
            return const Text('No resources uploaded');
          }

          return const HomeScreenLayout();
          // ListView.builder(
          //   itemCount: snapshot.data!.length,
          //   itemBuilder: (context, index) {
          //     var resourceObject = snapshot.data![index];

          //     return Card(
          //       child: ListTile(
          //         title: Text(resourceObject.resourceTitle),
          //         trailing: IconButton(
          //           onPressed: () {
          //             if (resourceObject.resourceFiles == null) return;

          //             downloadResource(resourceObject.resourceFiles!);
          //           },
          //           icon: const Icon(Icons.download),
          //         ),
          //       ),
          //     );
          //   },
          // );
        }

        return const Text('Loading...');
      },
    ));
  }
}
