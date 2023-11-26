import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/widgets/dropdowns/custom_dropdown.dart';
import 'package:iba_resources_app/widgets/image_input.dart';
import 'package:iba_resources_app/widgets/textfields/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:iba_resources_app/constants/dropdown_items.dart';

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  final _resourceNameController = TextEditingController();
  final _resourceDescriptionController = TextEditingController();
  final _teacherNameController = TextEditingController();
  final _semesterController = TextEditingController();
  final _yearController = TextEditingController();

  File? _selectedImage;

  late FilePickerResult pickedFiles;

  String getFileExtension(String filePath) {
    return extension(filePath).toLowerCase();
  }

  // returns the download URL of given file
  Future<String> _uploadToFirebaseStorage(File file) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // get file name
    String fileName = basename(file.path);

    // put file in documents collection, files stored in a folder whose name is given by user, individual files will have their own names+currentTimeStamp to avoid duplicity
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('documents')
        .child(_resourceNameController.text)
        .child('$fileName-$currentTimeStamp');

    await storageRef.putFile(file);

    String fileUrl = await storageRef.getDownloadURL();

    return fileUrl;
  }

  Future<FilePickerResult?> _selectFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return null;

    pickedFiles = result;

    return pickedFiles;
  }

  void _uploadResource() async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    List<String> fileUrls = [];

    // maps over each file path and converts to a File object, then converts to list
    List<File> files = pickedFiles.paths.map((path) => File(path!)).toList();

    // uploads each file to FB storage, gets individual download URL and adds URL to fileURLS list
    for (File file in files) {
      String fileUrl = await _uploadToFirebaseStorage(file);

      fileUrls.add(fileUrl);
    }

    await FirebaseFirestore.instance
        .collection('resources')
        .doc('${_resourceNameController.text}-$timeStamp')
        .set({
      'resourceTitle': _resourceNameController.text,
      'resourceFiles': fileUrls,
      'uploader': 'Farhan Mushi', //FirebaseAuth.instance.currentUser,
      'teacherName': _teacherNameController.text,
      'relevantFields': [],
      'semester': _semesterController.text,
      'year': _yearController.text,
      'isActive': true,
      'isDeleted': false,
      'createdAt': DateTime.now(),
      'updatedAt': null,
    });

    print(fileUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListView(
        children: [
          //
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Lottie.asset(
              'assets/FileUploadAnimation.json',
              repeat: false,
              frameRate: FrameRate(420),
              height: 300,
            ),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/resourceDetails");
            },
            child: Text(
              'Select Files',
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
            ),
          )
        ],
      ),
    );
  }
}
