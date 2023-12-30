import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_resources_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/utils/functions.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/report_resource.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/skeleton_text.dart';

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

  void _handleLike() {
    BlocProvider.of<UserBloc>(context).add(
      UserToggleLikeEvent(authenticatedUser, widget.resource),
    );

    _isLiked = !_isLiked;

    // if F=F but disliked=F then no run; dislike stays same
    if (_isLiked == _isDisiked && _isDisiked) {
      _isDisiked = !_isDisiked;
    }
  }

  void _handleDislike() {
    BlocProvider.of<UserBloc>(context).add(
      UserToggleDislikeEvent(authenticatedUser, widget.resource),
    );

    _isDisiked = !_isDisiked;

    if (_isDisiked == _isLiked && _isLiked) {
      _isLiked = !_isLiked;
    }
  }

  @override
  void initState() {
    super.initState();

    datePosted = Utils.formatTimeAgo(widget.resource.createdAt.toString());

    final signInBloc = BlocProvider.of<SignInBloc>(context);

    if (signInBloc.state is SignInValidState) {
      authenticatedUser =
          (signInBloc.state as SignInValidState).authenticatedUser;

      print('authenticatedUser is ${authenticatedUser.email}');

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
                      CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: ClipOval(
                          child: SvgPicture.network(
                            widget.resource.uploaderAvatar,
                            placeholderBuilder: (BuildContext context) =>
                                const AnimatedSkeletonText(
                              height: 80,
                              width: 80,
                            ),
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
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

        // likes + dislikes
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
                // like resource
                Expanded(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: InkWell(
                      onTap: _handleLike,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // likes count
                          Text(
                            widget.resource.likes.toString(),
                            // resourceLikes.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _isLiked
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
                          ),

                          const SizedBox(width: 8),

                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: _isLiked
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary,
                            size: 20,
                          ),
                        ],
                      ),
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
                    child: InkWell(
                      onTap: _handleDislike,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // likes count
                          Text(
                            widget.resource.dislikes.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _isDisiked
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
                          ),

                          const SizedBox(width: 8),

                          FaIcon(
                            FontAwesomeIcons.heartCrack,
                            color: _isDisiked
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // comment resource
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
