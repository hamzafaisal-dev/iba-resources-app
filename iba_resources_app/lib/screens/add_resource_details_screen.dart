import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/constants/dropdown_items.dart';
import 'package:iba_resources_app/widgets/dropdowns/custom_dropdown.dart';
import 'package:iba_resources_app/widgets/textfields/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

class AddResourceDetailsScreen extends StatefulWidget {
  const AddResourceDetailsScreen({super.key});

  @override
  State<AddResourceDetailsScreen> createState() =>
      _AddResourceDetailsScreenState();
}

class _AddResourceDetailsScreenState extends State<AddResourceDetailsScreen> {
  final _resourceNameController = TextEditingController();

  final _resourceDescriptionController = TextEditingController();

  final _teacherNameController = TextEditingController();

  final _semesterController = TextEditingController();

  final _yearController = TextEditingController();

  late FilePickerResult pickedFiles;

  final _createResourceFormKey = GlobalKey<FormState>();

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

  void _uploadResource() async {
    try {
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
        'resourceDescription': _resourceDescriptionController.text,
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
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _createResourceFormKey,
          child: ListView(
            children: [
              //

              // const SizedBox(height: 20),

              // // Add Details
              // Text(
              //   'Add Details',
              //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
              //         fontSize: 24,
              //         color: Theme.of(context).colorScheme.tertiary,
              //       ),
              // ),

              const SizedBox(height: 5),

              CustomTextFormField(
                labelText: 'Enter resource name',
                hintText: 'Eg. Business Communication Midterm Exam',
                maxInputLength: 45,
                setInput: (value) {},
              ),

              const SizedBox(height: 24),

              CustomTextFormField(
                labelText: 'Write a short description',
                hintText: 'Eg. Pictures of B.Comm midterm exam',
                maxInputLength: 500,
                maxInputLines: 11,
                setInput: (value) {},
              ),

              const SizedBox(height: 24),

              CustomTextFormField(
                labelText: 'Who taught this course?',
                hintText: 'Eg. Ms. Fatima Hatim Anjary',
                maxInputLength: 45,
                setInput: (value) {},
              ),

              const SizedBox(height: 24),

              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // relevantFields dropdwon
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.degreePrograms,
                    labelText: 'Select relevant fields',
                    width: MediaQuery.of(context).size.width / 1.35,
                  ),

                  const Spacer(),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 58,
                    width: 58,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 4),

              Wrap(
                direction: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  // individual degree chip
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        //
                        const Chip(
                          label: Text('MS (Development Studies)'),
                        ),

                        Positioned(
                          right: -4,
                          top: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: InkWell(
                                onTap: () {
                                  print('Potty');
                                },
                                child: const Icon(
                                  Icons.clear,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // semester dropdwon
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.semesterDropdownItems,
                    labelText: 'Select semester',
                    width: MediaQuery.of(context).size.width / 2.3,
                  ),

                  const SizedBox(width: 18),

                  // year dropdown
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.yearDropdownItems,
                    labelText: 'Select year',
                    width: MediaQuery.of(context).size.width / 2.3,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              FilledButton(
                onPressed: () {
                  if (_createResourceFormKey.currentState!.validate()) {
                    _uploadResource();
                  }
                },
                child: Text(
                  'Upload Resource',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
