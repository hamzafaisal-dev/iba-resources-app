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

class DisLikeResourceChip extends StatefulWidget {
  DisLikeResourceChip({
    super.key,
    required this.resource,
    required this.count,
    required this.isDisliked,
  });

  int count;
  final ResourceModel resource;
  final bool isDisliked;

  @override
  State<DisLikeResourceChip> createState() => _DisLikeResourceChipState();
}

class _DisLikeResourceChipState extends State<DisLikeResourceChip> {
  late int resourceDisikes;
  late UserModel authenticatedUser;

  late bool _isDisliked;

  void _toggleCount() {
// int resourceLikes = widget.resource.likes;
// int resourcedisLikes = widget.resource.dislikes;

    // ResourceModel updatedResource =
    //     widget.resource.copyWith(likes: widget.count);

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;

      BlocProvider.of<UserBloc>(context).add(
        UserToggleDislikeEvent(authenticatedUser, widget.resource),
      );

      bool isResourceMatch(ResourceModel dislikedResource) {
        return dislikedResource.resourceId == widget.resource.resourceId;
      }

      // _isDisliked = authenticatedUser.dislikedResources!.any(isResourceMatch);

      _isDisliked = !_isDisliked;

      _isDisliked ? resourceDisikes += 1 : resourceDisikes -= 1;
    }

    if (userBloc.state is ResourceLikedState) {
      List<int> resourceLikesAndDislikes =
          (userBloc.state as ResourceLikedState).resourceLikesAndDislikes;

      int newDislikesCount = resourceLikesAndDislikes[1];

      newDislikesCount =
          _isDisliked ? newDislikesCount - 1 : newDislikesCount + 1;

      print(newDislikesCount);

      // resourceDisikes = newDislikesCount;

      // resourceDisikes = resourceLikesAndDislikes[1];
    }
  }

  @override
  void initState() {
    resourceDisikes = widget.resource.dislikes;

    _isDisliked = widget.isDisliked;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _toggleCount();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // likes count
          Text(
            resourceDisikes.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _isDisliked
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
            ),
          ),

          const SizedBox(width: 8),

          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14),
            child: FaIcon(
              FontAwesomeIcons.heartCrack,
              color: _isDisliked
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
