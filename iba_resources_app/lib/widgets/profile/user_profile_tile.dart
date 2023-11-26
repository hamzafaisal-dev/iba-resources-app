import 'package:flutter/material.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.leadingIconSize,
    this.trailing,
    this.onTap,
  });

  final IconData leadingIcon;
  final double? leadingIconSize;
  final String title;
  final Widget? trailing;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0XFFE6FAF8),
          child: Icon(
            leadingIcon,
            color: const Color(0XFF01D3B0),
            size: leadingIconSize ?? 35,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
