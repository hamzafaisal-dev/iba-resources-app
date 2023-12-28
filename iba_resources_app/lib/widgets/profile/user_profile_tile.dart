import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    this.leadingIcon,
    this.avatarLink,
    required this.title,
    this.leadingIconSize,
    this.trailing,
    this.onTap,
  });

  final IconData? leadingIcon;
  final double? leadingIconSize;
  final String title;
  final String? avatarLink;

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
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: avatarLink != null
              ? ClipOval(
                  child: SvgPicture.network(
                    avatarLink!,
                    placeholderBuilder: (BuildContext context) =>
                        const Icon(Icons.person),
                    height: 47,
                    width: 47,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                )
              : Icon(
                  leadingIcon,
                  color: const Color(0XFF01D3B0),
                  size: leadingIconSize ?? 35,
                ),
        ),
        trailing: trailing,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
