import 'package:flutter/material.dart';

class ResourceTypeChip extends StatelessWidget {
  const ResourceTypeChip({
    super.key,
    required this.label,
    this.fontSize,
    this.textColor,
    this.backgroundColor,
  });

  final String label;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Chip(
        elevation: 2,
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w900,
            color:
                textColor ?? Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
