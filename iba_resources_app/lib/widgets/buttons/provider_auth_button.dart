import 'package:flutter/material.dart';

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton(
      {super.key,
      required this.imageSrc,
      required this.buttonLabel,
      required this.onTap,
      this.backgroundColor,
      this.foregroundColor});

  final String imageSrc;
  final String buttonLabel;
  final dynamic Function() onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton(
        onPressed: onTap,
        style: Theme.of(context).filledButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all(4),
              backgroundColor: MaterialStateProperty.all<Color>(
                  backgroundColor ?? Theme.of(context).colorScheme.primary),
              foregroundColor: MaterialStateProperty.all<Color>(
                foregroundColor ?? Colors.white,
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageSrc,
              width: 25,
              height: 25,
            ),
            const SizedBox(width: 10),
            Text(
              buttonLabel,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
