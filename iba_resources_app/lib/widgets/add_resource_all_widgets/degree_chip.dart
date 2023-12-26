import 'package:flutter/material.dart';

class DegreeChip extends StatelessWidget {
  const DegreeChip({
    super.key,
    required this.label,
    required this.onRemove,
  });

  final String label;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          //
          Chip(
            label: Text(label),
          ),

          Positioned(
            right: -4,
            top: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: InkWell(
                  onTap: () {
                    onRemove();
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
