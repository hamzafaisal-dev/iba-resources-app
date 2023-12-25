import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/styles.dart';

class NameFormField extends StatefulWidget {
  const NameFormField({
    super.key,
    required this.helperLabel,
    required this.leadingIcon,
    required this.setName,
  });

  final String helperLabel;
  final IconData leadingIcon;
  final void Function(String email) setName;

  @override
  State<NameFormField> createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<NameFormField> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.helperLabel;

    return TextFormField(
      decoration: TextFormFieldStyles.textFormFieldDecoration(
        widget.helperLabel,
        Icon(widget.leadingIcon),
        null,
        context,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      controller: _nameController,
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().length < 3) {
          return 'Name cannot be less than 3 characters';
        }

        widget.setName(value);
        _nameController.clear();
        return null;
      },
    );
  }
}
