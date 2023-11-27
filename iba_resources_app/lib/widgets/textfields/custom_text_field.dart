import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.leadingIcon,
    this.maxInputLength,
    this.maxInputLines,
    required this.setInput,
  });

  final String labelText;
  final String hintText;
  final IconData? leadingIcon;
  final int? maxInputLength;
  final int? maxInputLines;

  final void Function(String input) setInput;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final _inputTextController = TextEditingController();

  @override
  void dispose() {
    _inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //
      decoration: TextFormFieldStyles.textFormFieldDecoration(
        widget.labelText,
        Icon(widget.leadingIcon),
        null,
        context,
      ).copyWith(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      controller: _inputTextController,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid input';
        }

        print('object');
        widget.setInput(value);
        return null;
      },

      maxLines: widget.maxInputLines,

      maxLength: widget.maxInputLength,

      // gets rid of maxLength counter under text fields
      buildCounter: (
        context, {
        required currentLength,
        maxLength,
        required isFocused,
      }) =>
          null,
    );
  }
}
