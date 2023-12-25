import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/utils/functions.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/dislike_resource_chip.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/like_resource_chip.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/report_resource.dart';

class ResourceTile extends StatefulWidget {
  const ResourceTile({
    super.key,
    required this.resource,
  });

  final ResourceModel resource;

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  late UserModel authenticatedUser;
  late List<ResourceModel> userLikedResources;
  late List<ResourceModel> userDislikedResources;

  bool _isLiked = false;
  bool _isDisiked = false;

  late String datePosted;

  @override
  void initState() {
    datePosted = Utils.formatTimeAgo(widget.resource.createdAt.toString());

    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;

      userLikedResources = authenticatedUser.likedResources!;
      userDislikedResources = authenticatedUser.dislikedResources!;

      userLikedResources.any((likedResource) {
        if (likedResource.resourceId == widget.resource.resourceId) {
          print(likedResource.resourceTitle);
          _isLiked = true;
        }

        return false;
      });

      userDislikedResources.any((disLikedResource) {
        if (disLikedResource.resourceId == widget.resource.resourceId) {
          print(disLikedResource.resourceTitle);
          _isDisiked = true;
        }

        return false;
      });
    }

    // TODO: implement initState
    super.initState();
  }

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
                      const CircleAvatar(
                        radius: 13,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),

                      const SizedBox(width: 6),

                      // username
                      Text(
                        widget.resource.uploader,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    datePosted,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // resource title
              Text(
                widget.resource.resourceTitle,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              // resource description
              Text(
                Utils.truncateString(widget.resource.resourceDescription),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
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
            child: Row(
              children: [
                //

                // like resource
                Expanded(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: const BoxDecoration(
                      // color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: LikeResourceChip(
                      resource: widget.resource,
                      count: widget.resource.likes,
                      isLiked: _isLiked,
                    ),
                  ),
                ),

                // dislike resource
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                        right: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                    child: DisLikeResourceChip(
                      resource: widget.resource,
                      count: widget.resource.likes,
                      isDisliked: _isDisiked,
                    ),
                  ),
                ),

                // share resource
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ReportResourceChip(
                      resourceId: widget.resource.resourceId,
                      count: widget.resource.likes,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
