import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/styles.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.helperLabel,
    required this.leadingIcon,
    this.trailingIcon,
    required this.setPassword,
  });

  final String helperLabel;
  final IconData leadingIcon;
  final IconData? trailingIcon;

  final void Function(String password) setPassword;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _passwordHidden = true;

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: TextFormFieldStyles.textFormFieldDecoration(
        widget.helperLabel,
        Icon(widget.leadingIcon),
        IconButton(
          onPressed: () {
            setState(() {
              _passwordHidden = !_passwordHidden;
            });
          },
          icon: _passwordHidden
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
        context,
      ),
      obscureText: _passwordHidden,
      cursorColor: Theme.of(context).colorScheme.primary,
      keyboardType: TextInputType.emailAddress,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().length < 6) {
          return 'Password should contain at least 6 characters ';
        }
        widget.setPassword(value);
        return null;
      },
    );
  }
}
