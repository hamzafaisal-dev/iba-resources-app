import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';

class RewardTile extends StatelessWidget {
  const RewardTile({
    super.key,
    required this.title,
    this.leadingIconSize,
    this.trailing,
    this.onTap,
    required this.rewardPoints,
    required this.userPoints,
  });

  final double? leadingIconSize;
  final String title;
  final Widget? trailing;
  final dynamic Function()? onTap;
  final int rewardPoints;
  final int userPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        //
        color: userPoints >= rewardPoints
            ? Colors.white
            : const Color.fromARGB(255, 190, 189, 189),

        elevation: 1,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),

        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: userPoints >= rewardPoints
                ? Theme.of(context).colorScheme.primaryContainer
                : const Color.fromARGB(255, 228, 228, 228),
            child: Icon(
              userPoints >= rewardPoints
                  ? Icons.card_giftcard_outlined
                  : Icons.lock_rounded,
              color: userPoints >= rewardPoints
                  ? Theme.of(context).colorScheme.primary
                  : const Color.fromARGB(255, 190, 189, 189),
              size: leadingIconSize ?? 32,
            ),
          ),
          trailing: trailing,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: userPoints >= rewardPoints
                  ? Colors.black
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
