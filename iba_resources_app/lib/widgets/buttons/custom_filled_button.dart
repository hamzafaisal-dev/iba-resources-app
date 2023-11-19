import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.buttonLabel,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 0,
    this.paddingX = 0,
    this.paddingY = 0,
    this.foregroundColor,
    this.backgroundColor,
    this.onTap,
  });

  final String buttonLabel;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final double paddingX;
  final double paddingY;
  final MaterialStateProperty<Color>? foregroundColor;
  final MaterialStateProperty<Color>? backgroundColor;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
        ),
        foregroundColor:
            foregroundColor ?? MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            backgroundColor ?? MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: onTap,
      child: Text(
        buttonLabel,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
