import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DislikeResourceChip extends StatefulWidget {
  DislikeResourceChip({
    super.key,
    required this.resourceId,
    required this.count,
    required this.icon,
  });

  int count;
  final String resourceId;
  final Widget icon;

  @override
  State<DislikeResourceChip> createState() => _DislikeResourceChipState();
}

class _DislikeResourceChipState extends State<DislikeResourceChip> {
  bool _isLiked = false;

  void _toggleCount() {
    _isLiked ? widget.count -= 1 : widget.count += 1;
    _isLiked = !_isLiked;

    // get the relevant document by it's id
    DocumentReference<Map<String, dynamic>> resourceRef = FirebaseFirestore
        .instance
        .collection('/resources')
        .doc(widget.resourceId);

    resourceRef.update({'dislikes': widget.count});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _toggleCount();
        });
      },
      child: Chip(
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
      ),
    );
  }
}
