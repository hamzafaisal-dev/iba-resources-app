import 'package:flutter/material.dart';

class SavedResourceTile extends StatelessWidget {
  const SavedResourceTile({
    super.key,
    required this.title,
    this.leadingIconSize,
    this.trailing,
    this.onTap,
  });

  final double? leadingIconSize;
  final String title;
  final Widget? trailing;

  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.bookmark,
              color: Theme.of(context).colorScheme.primary,
              size: leadingIconSize ?? 32,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
