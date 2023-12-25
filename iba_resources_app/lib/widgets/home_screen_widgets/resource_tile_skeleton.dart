import 'package:flutter/material.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/skeleton_text.dart';

class ResourceTileSkeleton extends StatelessWidget {
  const ResourceTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Container(
          decoration: const BoxDecoration(
            color: Color(0XFFF2F6F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              const SizedBox(height: 9),

              // pfp + username
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // pfp + username
                  Row(
                    children: [
                      // pfp
                      AnimatedSkeletonText(
                        borderRadius: BorderRadius.circular(50),
                        height: 28,
                        width: 28,
                      ),

                      const SizedBox(width: 6),

                      // username
                      AnimatedSkeletonText(
                        borderRadius: BorderRadius.circular(5),
                        width: 90,
                      )
                    ],
                  ),

                  AnimatedSkeletonText(
                    borderRadius: BorderRadius.circular(5),
                    width: 90,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // resource title
              AnimatedSkeletonText(
                borderRadius: BorderRadius.circular(5),
                height: 40,
                width: MediaQuery.of(context).size.width / 1.7,
              ),

              const SizedBox(height: 8),

              // resource description
              AnimatedSkeletonText(
                borderRadius: BorderRadius.circular(5),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 14),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0XFFF2F6F7),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
            child: const AnimatedSkeletonText(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
