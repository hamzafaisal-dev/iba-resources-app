import 'package:flutter/material.dart';

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.actionTitle,
    required this.actionIcon,
  });

  final String actionTitle;
  final Icon actionIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: actionIcon,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[500],
        ),
        title: Text(
          actionTitle,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
