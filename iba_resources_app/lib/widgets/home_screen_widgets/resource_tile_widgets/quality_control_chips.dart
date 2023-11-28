import 'package:flutter/material.dart';

class QualityControlChip extends StatefulWidget {
  const QualityControlChip(
      {super.key, required this.count, required this.icon});

  final int count;
  final Widget icon;

  @override
  State<QualityControlChip> createState() => _QualityControlChipState();
}

class _QualityControlChipState extends State<QualityControlChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 1.5,
      backgroundColor: Colors.white,
      label: Row(
        children: [
          // likes count
          Text(
            widget.count.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(width: 4),

          widget.icon
        ],
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
