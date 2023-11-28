import 'package:flutter/material.dart';

class ResourceTypeChip extends StatelessWidget {
  const ResourceTypeChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 2,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
