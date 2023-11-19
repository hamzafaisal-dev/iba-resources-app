import 'package:flutter/material.dart';

class UserProfileStat extends StatelessWidget {
  const UserProfileStat({
    super.key,
    required this.statisticValue,
    required this.statisticName,
  });

  final int statisticValue;
  final String statisticName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //

          // statistic value
          Text(
            statisticValue.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 60,
            ),
          ),

          // statistic name
          Text(
            statisticName,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
