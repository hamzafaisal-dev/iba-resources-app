import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iba_resources_app/features/auth/repository/auth_repository.dart';

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton({
    super.key,
    required this.imageSrc,
    required this.buttonLabel,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

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

class GoogleButton extends ConsumerWidget {
  const GoogleButton({
    super.key,
    required this.imageSrc,
    required this.buttonLabel,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String imageSrc;
  final String buttonLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authRepoProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton(
        //
        onPressed: () => signInWithGoogle(ref),

        style: Theme.of(context).filledButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all(4),
              backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? Theme.of(context).colorScheme.primary,
              ),
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

class FacebookButton extends ConsumerWidget {
  const FacebookButton({
    super.key,
    required this.imageSrc,
    required this.buttonLabel,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String imageSrc;
  final String buttonLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;

  void signInWithFacebook(WidgetRef ref) {
    ref.read(authRepoProvider).signInWithFacebook();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton(
        //
        onPressed: () => signInWithFacebook(ref),

        style: Theme.of(context).filledButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all(4),
              backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? Theme.of(context).colorScheme.primary,
              ),
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
