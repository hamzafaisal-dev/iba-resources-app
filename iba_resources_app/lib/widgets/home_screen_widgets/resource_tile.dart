import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/icons.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/quality_control_chips.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/resource_type_chip.dart';

class ResourceTile extends StatelessWidget {
  const ResourceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFF2F6F7),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      margin: const EdgeInsets.only(bottom: 14),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //

          // pfp + username
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // pfp + username
              Row(
                children: [
                  // pfp
                  const CircleAvatar(
                    radius: 13,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),

                  const SizedBox(width: 6),

                  // username
                  Text(
                    'Younas Mahmood',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),

              const Icon(Icons.more_horiz)
            ],
          ),

          const SizedBox(height: 8),

          // resource title
          const Text(
            'BComm. Midterm Exam pictures',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // resource description
          Text(
            'The quick brown fox jumps over the lazy dogfdgf...',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          const SizedBox(height: 8),

          // resource type + likes/dislikes buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // resource type
              const ResourceTypeChip(label: 'Midterm'),

              // likes + dislikes
              Row(
                children: [
                  // likes button
                  QualityControlChip(
                    count: 743,
                    icon: HomeScreenIcons.thumbsUp,
                  ),

                  const SizedBox(width: 8),

                  // dislikes button
                  QualityControlChip(
                    count: 22,
                    icon: HomeScreenIcons.thumbsDown,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
