import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/constants/dropdown_items.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/widgets/dropdowns/custom_dropdown.dart';
import 'package:iba_resources_app/widgets/progress_indicators/button_progress_indicator.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/degree_chip.dart';
import 'package:iba_resources_app/widgets/textfields/custom_text_field.dart';

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

  late FilePickerResult _pickedFiles;

  late UserModel _authenticatedUser;

  final _createResourceFormKey = GlobalKey<FormState>();

  void _addRelevantDegree(String? relevantDegree) {
    if (relevantDegree != null && relevantDegree.isNotEmpty) {
      if (_relevantFields.contains(relevantDegree)) return;

      setState(() {
        _relevantFields.add(relevantDegree);
      });
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _uploadResource(UserModel authenticatedUser) {
    BlocProvider.of<ResourceBloc>(context).add(
      UploadFilesEvent(
        pickedFiles: _pickedFiles,
        resourceTitle: _resourceTitle,
        resourceDescription: _resourceDescription,
        resourceType: _resourceType,
        teacherName: _teacherName,
        courseName: _courseName,
        relevantFields: _relevantFields,
        semester: _semester,
        year: _year,
        updatedUser: authenticatedUser,
      ),
    );
  }

  @override
  void initState() {
    // access the auth blok using the context
    final authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    // get files from the previous screen
    if (widget.arguments != null) {
      _pickedFiles = widget.arguments!["pickedFiles"];

      print('picked files in add resource details screen: $_pickedFiles');
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
          child: BlocConsumer<ResourceBloc, ResourceState>(
            listener: (context, state) {
              if (state is ResourceFilesUploadSuccess) {
                showSnackbar('Resource uploaded successfully');
              }

              if (state is ResourceError) {
                showSnackbar(state.errorMsg);
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
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
                    onPressed: (state is ResourceFilesUploadLoading)
                        ? null
                        : () {
                            if (_createResourceFormKey.currentState!
                                .validate()) {
                              _uploadResource(_authenticatedUser);
                            }
                          },
                    child: (state is ResourceFilesUploadLoading)
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
              );
            },
          ),
        ),
      ),
    );
  }
}
