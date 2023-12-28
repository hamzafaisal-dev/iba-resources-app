import 'package:flutter/material.dart';
import 'package:iba_resources_app/utils/functions.dart';

class FileNameTile extends StatelessWidget {
  const FileNameTile({
    super.key,
    required this.fileName,
    required this.fileType,
  });

  final String fileName;
  final String? fileType;

  @override
  Widget build(BuildContext context) {
    late Widget fileImageIcon;

    if (fileType != null) {
      fileImageIcon = Utils.getFileTypeImage(fileType!);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          fileImageIcon,
          Expanded(
            child: Card(
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 10),
                title: Text(
                  fileName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                // trailing: Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.primaryContainer,
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(50),
                //       bottomLeft: Radius.circular(50),
                //     ),
                //   ),
                //   height: MediaQuery.of(context).size.height,
                //   width: 100,
                //   child: Center(
                //     child: Text(
                //       Utils.formatFileSize(fileSize),
                //       style: const TextStyle(
                //         fontWeight: FontWeight.w900,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
