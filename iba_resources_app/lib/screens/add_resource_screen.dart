import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/selectedFileTile.dart';
import 'package:lottie/lottie.dart';

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  FilePickerResult? pickedFiles;

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

  void _selectFiles() {
    BlocProvider.of<ResourceBloc>(context).add(SelectFilesEvent());
  }

  // @override
  // void dispose() {
  //   BlocProvider.of<ResourceBloc>(context).close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: BlocConsumer<ResourceBloc, ResourceState>(
        listener: (context, state) {
          if (state is ResourceError) {
            showSnackbar(state.errorMsg);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              // animaton
              Container(
                //
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

              // select files button
              FilledButton(
                onPressed: () {
                  _selectFiles();
                },
                child: Text(
                  'Select Files',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              if (state is ResourceFilesSelectSuccess)
                // Selected Files + Proceed
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Text(
                        'Selected Files: ${state.filePickerResult!.files.length | 0}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),

                      // proceed to add reource details screen
                      InkWell(
                        onTap: () => {
                          NavigationService.routeToNamed(
                            "/resourceDetails",
                            arguments: {"pickedFiles": state.filePickerResult},
                          )
                        },
                        child: Row(
                          children: [
                            //
                            Text(
                              'Proceed',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            const SizedBox(width: 4),

                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              // selected files list
              if (state is ResourceFilesSelectSuccess)
                ...state.filePickerResult!.files.map(
                  (file) => FileNameTile(
                    fileName: file.name,
                    fileType: file.extension,
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
