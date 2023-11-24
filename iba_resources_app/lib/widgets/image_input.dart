import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  String? imageName;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);

        imageName = result.files.single.path!
            .substring(result.files.single.path!.lastIndexOf('/') + 1);
      });

      widget.onPickImage(_selectedImage!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = IconButton(
      onPressed: _pickFile,
      icon: const Icon(Icons.camera),
      // label: const Text('Take Picture'),
    );

    if (_selectedImage != null) {
      content = InkWell(
        onTap: _pickFile,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
      );
    }

    return Column(
      children: [
        if (imageName != null) Text(imageName!),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          height: 250,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: content,
        ),
      ],
    );
  }
}
