import 'package:flutter/material.dart';
import 'package:iba_resources_app/constants/icons.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/dislike_resource_chip.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/like_resource_chip.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/resource_type_chip.dart';

class ResourceTile extends StatelessWidget {
  const ResourceTile({
    super.key,
    required this.resourceId,
    required this.resourceTitle,
    required this.resourceDescription,
    required this.uploader,
    required this.resourceType,
    required this.likes,
    required this.dislikes,
  });

  final String resourceId;
  final String resourceTitle;
  final String resourceDescription;
  final String uploader;
  final String resourceType;
  final int likes;
  final int dislikes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFF2F6F7),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: Colors.black, width: 1.5),
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
                    uploader,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // resource title
          Text(
            resourceTitle,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 8),

          // resource description
          Text(
            resourceDescription,
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
              ResourceTypeChip(label: resourceType),

              // likes + dislikes
              Row(
                children: [
                  // likes button
                  LikeResourceChip(
                    resourceId: resourceId,
                    count: likes,
                    icon: HomeScreenIcons.thumbsUp,
                  ),

                  const SizedBox(width: 8),

                  // dislikes button
                  DislikeResourceChip(
                    resourceId: resourceId,
                    count: dislikes,
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
