import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/constants/dropdown_items.dart';
import 'package:iba_resources_app/constants/styles.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/dropdowns/custom_dropdown.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/degree_chip.dart';
import 'package:iba_resources_app/widgets/textfields/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

class AddResourceDetailsScreen extends StatefulWidget {
  const AddResourceDetailsScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<AddResourceDetailsScreen> createState() =>
      _AddResourceDetailsScreenState();
}

class _AddResourceDetailsScreenState extends State<AddResourceDetailsScreen> {
  String _resourceTitle = '';
  String _resourceDescription = '';
  String _courseName = '';
  String _teacherName = '';
  String _selectedRelevantField = '';
  final List<String> _relevantFields = [];
  String _resourceType = '';
  String _semester = '';
  String _year = '';

  late FilePickerResult pickedFiles;

  bool _isLoading = false;

  final _createResourceFormKey = GlobalKey<FormState>();

  void _addRelevantDegree(String? relevantDegree) {
    if (relevantDegree != null && relevantDegree.isNotEmpty) {
      if (_relevantFields.contains(relevantDegree)) return;

      setState(() {
        _relevantFields.add(relevantDegree);
      });
    }
  }

  // returns the download URL of given file
  Future<String> _uploadToFirebaseStorage(File file) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // get file name
    String fileName = basename(file.path);

    // put file in documents collection, files stored in a folder whose name is given by user, individual filenames will be their own names+currentTimeStamp to avoid duplicity
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('documents')
        .child(_resourceTitle)
        .child('$fileName-$currentTimeStamp');

    await storageRef.putFile(file);

    String fileUrl = await storageRef.getDownloadURL();

    return fileUrl;
  }

  void _uploadResource() async {
    try {
      setState(() => _isLoading = true);

      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

      List<String> _fileUrls = [];

      // maps over each file path and converts to a File object, then converts to list
      List<File> files = pickedFiles.paths.map((path) => File(path!)).toList();

      // uploads each file to FB storage, gets individual download URL and adds URL to fileURLS list
      for (File file in files) {
        String fileUrl = await _uploadToFirebaseStorage(file);

        _fileUrls.add(fileUrl);
      }

      await FirebaseFirestore.instance
          .collection('resources')
          .doc('$_resourceTitle-$timeStamp')
          .set({
        'resourceId': '$_resourceTitle-$timeStamp',
        'resourceTitle': _resourceTitle,
        'resourceFiles': _fileUrls,
        'resourceDescription': _resourceDescription,
        'resourceType': _resourceType,
        'uploader': 'Farhan Mushi', //FirebaseAuth.instance.currentUser,
        'teacherName': _teacherName,
        'courseName': _courseName,
        'relevantFields': _relevantFields,
        'semester': _semester,
        'year': _year,
        'likes': 0,
        'dislikes': 0,
        'reportCount': 0,
        'isActive': true,
        'isDeleted': false,
        'createdAt': DateTime.now(),
        'updatedAt': null,
      }).then(
        (value) => NavigationService.routeToNamed("/layout"),
      );

      // setState(() => _isLoading = false);

      // print(_fileUrls);
    } catch (error) {
      setState(() => _isLoading = false);

      // print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // get files from the previous screen

    if (widget.arguments != null) {
      pickedFiles = widget.arguments!["pickedFiles"];
    }

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

              const SizedBox(height: 5),

              // resource name field
              CustomTextFormField(
                labelText: 'Enter resource name',
                hintText: 'Eg. Business Communication Midterm Exam',
                maxInputLength: 45,
                setInput: (String resourceName) {
                  _resourceTitle = resourceName;
                },
              ),

              const SizedBox(height: 24),

              // resource description field
              CustomTextFormField(
                labelText: 'Write a short description',
                hintText: 'Eg. Pictures of B.Comm midterm exam',
                maxInputLength: 300,
                maxInputLines: 8,
                setInput: (String resourceDescription) {
                  _resourceDescription = resourceDescription;
                },
              ),

              const SizedBox(height: 24),

              // course name field
              CustomTextFormField(
                labelText: 'Enter course name',
                hintText: 'Eg. Business Communication',
                maxInputLength: 45,
                setInput: (String courseName) {
                  _courseName = courseName;
                },
              ),

              const SizedBox(height: 24),

              // teacher name field
              CustomTextFormField(
                labelText: 'Who taught this course?',
                hintText: 'Eg. Ms. Fatima Hatim Anjary',
                maxInputLength: 45,
                setInput: (String teacherName) {
                  _teacherName = teacherName;
                },
              ),

              const SizedBox(height: 24),

              // relevant degrees dropdown + add button
              Row(
                children: [
                  // relevantFields dropdwon
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.degreePrograms,
                    labelText: 'Select relevant fields',
                    hintText: 'Eg. BSCS',
                    width: MediaQuery.of(context).size.width / 1.35,
                    setInput: (String relevantDegreeOption) {
                      _selectedRelevantField = relevantDegreeOption;
                    },
                  ),

                  const Spacer(),

                  // add relevant degree button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 58,
                    width: 58,
                    child: IconButton(
                      onPressed: () {
                        _addRelevantDegree(_selectedRelevantField);
                      },
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

              // relevant degree chip tiles container
              Wrap(
                direction: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  ..._relevantFields.map(
                    (relevantField) => DegreeChip(label: relevantField),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // semester + year + type dropdowns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // semester dropdwon
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.semesterDropdownItems,
                    labelText: 'Select semester',
                    hintText: 'Fall',
                    width: MediaQuery.of(context).size.width / 3.6,
                    setInput: (String semesterOption) {
                      _semester = semesterOption;
                    },
                  ),

                  const SizedBox(width: 18),

                  // year dropdown
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.yearDropdownItems,
                    labelText: 'Select year',
                    hintText: '2010',
                    width: MediaQuery.of(context).size.width / 3.6,
                    setInput: (String yearOption) {
                      _year = yearOption;
                    },
                  ),

                  const SizedBox(width: 18),

                  // resource type dropdown
                  CustomDropdown(
                    dropDownMenuItems: DropdownItems.resourceTypes,
                    labelText: 'Select type',
                    hintText: 'Quiz',
                    width: MediaQuery.of(context).size.width / 3.6,
                    setInput: (String typeOption) {
                      _resourceType = typeOption;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // upload resource button
              FilledButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_createResourceFormKey.currentState!.validate()) {
                          _uploadResource();
                        }
                      },
                child: _isLoading
                    ? const ButtonProgressIndicator()
                    : Text(
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
