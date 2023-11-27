import 'package:flutter/material.dart';

class FileNameTile extends StatelessWidget {
  const FileNameTile({super.key, required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          fileName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
