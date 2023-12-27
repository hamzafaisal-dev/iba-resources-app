import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/user/user_bloc.dart';
import 'package:iba_resources_app/constants/icons.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class DislikeResourceChip extends StatefulWidget {
  DislikeResourceChip({
    super.key,
    // required this.resource,
    // required this.count,
    required this.isDisliked,
    required this.onDisliked,
  });

  // int count;
  // final ResourceModel resource;
  final bool isDisliked;
  final void Function() onDisliked;

  @override
  State<DislikeResourceChip> createState() => _DislikeResourceChipState();
}

class _DislikeResourceChipState extends State<DislikeResourceChip> {
  // late int resourceLikes;
  late UserModel authenticatedUser;

  late bool _isDisliked;

  void _toggleCount() {
// int resourceLikes = widget.resource.likes;
// int resourcedisLikes = widget.resource.dislikes;

    // ResourceModel updatedResource =
    //     widget.resource.copyWith(likes: widget.count);

    // final authBloc = BlocProvider.of<AuthBloc>(context);
    // final userBloc = BlocProvider.of<UserBloc>(context);

    // if (authBloc.state is AuthStateAuthenticated) {
    //   authenticatedUser =
    //       (authBloc.state as AuthStateAuthenticated).authenticatedUser;

    //   BlocProvider.of<UserBloc>(context).add(
    //     UserToggleLikeEvent(authenticatedUser, widget.resource),
    //   );

    //   bool isResourceMatch(ResourceModel likedResource) {
    //     return likedResource.resourceId == widget.resource.resourceId;
    //   }

    // _isDisliked = authenticatedUser.likedResources!.any(isResourceMatch);

    setState(() {
      _isDisliked = !_isDisliked;
    });

    // _isDisliked ? resourceLikes += 1 : resourceLikes -= 1;
  }

  // if (userBloc.state is ResourceLikedState) {
  //   List<int> resourceLikesAndDislikes =
  //       (userBloc.state as ResourceLikedState).resourceLikesAndDislikes;

  //   int newLikesCount = resourceLikesAndDislikes[0];

  //   newLikesCount = _isDisliked ? newLikesCount - 1 : newLikesCount + 1;

  //   print(newLikesCount);

  //   // resourceLikes = newLikesCount;
  // }

  @override
  void initState() {
    // resourceLikes = widget.resource.likes;

    _isDisliked = widget.isDisliked;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onDisliked();
        _toggleCount();
        // setState(() {
        //   _toggleCount();
        // });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // likes count
          Text(
            '0',
            // resourceLikes.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _isDisliked
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
            ),
          ),

          const SizedBox(width: 8),

          FaIcon(
            FontAwesomeIcons.heart,
            color: _isDisliked
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
