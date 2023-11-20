import 'package:flutter/material.dart';

class NamedDivider extends StatelessWidget {
  const NamedDivider({
    super.key,
    required this.dividerText,
    required this.dividerColor,
    this.dividerThickness,
  });

  final String dividerText;
  final Color dividerColor;
  final double? dividerThickness;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerThickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            dividerText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerThickness,
          ),
        ),
      ],
    );
  }
}
