import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

class ProfileStat extends StatelessWidget {
  const ProfileStat({
    super.key,
    required this.icon,
    required this.statisticName,
    required this.statisticValue,
  });

  final Icon icon;
  final String statisticName;
  final int statisticValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // hexagon widget
        HexagonWidget.pointy(
          width: 65,
          color: const Color.fromARGB(255, 240, 99, 89),
          padding: 6.0,
          child: icon,
        ),

        // stat value
        Text(
          statisticValue.toString(),
          style: TextStyle(
            fontSize: 26,
            color: Colors.grey[200],
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 0.0,
                color: Colors.black.withOpacity(
                  0.2,
                ),
              ),
            ],
          ),
        ),

        // stat name
        Text(
          statisticName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 0.0,
                color: Colors.black.withOpacity(
                  0.2,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
