import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/styles.dart';

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    super.key,
    required this.helperLabel,
    required this.leadingIcon,
    required this.setEmail,
  });

  final String helperLabel;
  final IconData leadingIcon;
  final void Function(String email) setEmail;

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: TextFormFieldStyles.textFormFieldDecoration(
        widget.helperLabel,
        Icon(widget.leadingIcon),
        null,
        context,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !value.contains('@khi.iba.edu.pk') ||
            value.trim().length < 20) {
          return 'Enter a valid IBA email address';
        }

        widget.setEmail(value);
        return null;
      },
    );
  }
}
