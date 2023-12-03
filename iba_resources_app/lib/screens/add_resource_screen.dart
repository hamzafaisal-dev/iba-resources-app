import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/selectedFileTile.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({super.key});

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  FilePickerResult? pickedFiles;

  String getFileExtension(String filePath) {
    return extension(filePath).toLowerCase();
  }

  Future<FilePickerResult?> _selectFiles(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return null;

    setState(() {
      pickedFiles = result;
    });

    print(pickedFiles);

    return pickedFiles;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListView(
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
              _selectFiles(context);
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

          // Selected Files
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                Text(
                  'Selected Files: ${pickedFiles?.files.length ?? 0}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),

                // proceed to add reource details screen
                if (pickedFiles != null && pickedFiles!.files.isNotEmpty)
                  InkWell(
                    onTap: () => {
                      print(pickedFiles),
                      // Navigator.of(context).pushNamed(
                      //   "/resourceDetails",
                      //   arguments: {"pickedFiles": pickedFiles},
                      // )

                      NavigationService.routeToNamed(
                        "/resourceDetails",
                        arguments: {"pickedFiles": pickedFiles},
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

          if (pickedFiles != null && pickedFiles!.files.isNotEmpty)
            ...pickedFiles!.files
                .map((file) => FileNameTile(fileName: file.name))
                .toList(),
        ],
      ),
    );
  }
}
