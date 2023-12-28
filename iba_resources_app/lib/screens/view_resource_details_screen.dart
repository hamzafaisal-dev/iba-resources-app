import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/utils/functions.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_widgets/resource_type_chip.dart';

class ViewResourceDetailsScreen extends StatefulWidget {
  const ViewResourceDetailsScreen({super.key, this.resourceMap});

  final Map<String, ResourceModel>? resourceMap;

  @override
  State<ViewResourceDetailsScreen> createState() =>
      _ViewResourceDetailsScreenState();
}

class _ViewResourceDetailsScreenState extends State<ViewResourceDetailsScreen> {
  bool _isBookmarked = false;

  void _downloadResource(List<dynamic> fileDownloadUrls) async {
    BlocProvider.of<ResourceBloc>(context)
        .add(DownloadResourceEvent(fileDownloadUrls: fileDownloadUrls));
  }

  void _bookmarkResource(ResourceModel resource, UserModel user) {
    BlocProvider.of<ResourceBloc>(context).add(
      BookmarkResourceEvent(
        user: user,
        savedResource: resource,
        isBookMarked: _isBookmarked,
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late ResourceModel currentResource;

    if (widget.resourceMap != null) {
      currentResource = widget.resourceMap!['resourceObject']!;
    }

    String datePosted =
        Utils.formatTimeAgo(currentResource.createdAt.toString());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateAuthenticated) {}
          },
          builder: (context, state) {
            if (state is AuthStateAuthenticated) {
              // if resource already present in user's saved resources array then initial value of _isBookmarked: true
              // if (state.authenticatedUser.savedResources!
              //     .contains(currentResource)) {
              //   _isBookmarked = true;
              // }

              for (ResourceModel userSavedResource
                  in state.authenticatedUser.savedResources!) {
                if (currentResource.resourceId ==
                    userSavedResource.resourceId) {
                  print('we finna here');
                  _isBookmarked = true;
                  break;
                }
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // resource title + bookmark icon
                BlocListener<ResourceBloc, ResourceState>(
                  listener: (context, state) {
                    if (state is ResourceBookmarkSuccess &&
                        _isBookmarked == true) {
                      showSnackbar('Resource bookmarked successfully!');
                    } else if (state is ResourceBookmarkSuccess &&
                        _isBookmarked == false) {
                      showSnackbar('Resource unbookmarked successfully!');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // resource title
                      Flexible(
                        // will wrap text
                        child: Text(
                          currentResource.resourceTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      // bookmark resource
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onPressed: () {
                          if (state is AuthStateAuthenticated) {
                            _bookmarkResource(
                              currentResource,
                              state.authenticatedUser,
                            );

                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                          }
                        },
                        icon: _isBookmarked
                            ? Icon(
                                Icons.bookmark,
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : Icon(
                                Icons.bookmark_outline,
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

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
                              currentResource.uploaderAvatar,
                              placeholderBuilder: (BuildContext context) =>
                                  const Icon(Icons.person),
                              height: 28,
                              width: 28,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              clipBehavior: Clip.hardEdge,
                            ),
                          ),
                        ),

                        const SizedBox(width: 6),

                        // username
                        Text(
                          currentResource.uploader,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),

                    // date posted
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

                const SizedBox(height: 12),

                Wrap(
                  children: [
                    //
                    ...currentResource.relevantFields!.map(
                      (relevantField) => ResourceTypeChip(
                        label: relevantField,
                        fontSize: 15.5,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    ResourceTypeChip(
                      label: currentResource.resourceType,
                      fontSize: 16,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // teacher name
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Teacher: ',
                      ),
                      TextSpan(
                        text: currentResource.teacherName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // semester
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Semester: ',
                      ),
                      TextSpan(
                        text:
                            '${currentResource.semester} ${currentResource.year}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // resource description
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Description: ',
                      ),
                      TextSpan(
                        text: currentResource.resourceDescription,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                BlocConsumer<ResourceBloc, ResourceState>(
                  listener: (context, state) {
                    if (state is ResourceFilesDownloadSuccess) {
                      showSnackbar('Resource downloaded succesfully');
                    }

                    if (state is ResourceError) {
                      showSnackbar(state.errorMsg);
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: FilledButton(
                        onPressed: (state is ResourceFilesDownloadLoading)
                            ? null
                            : () {
                                _downloadResource(
                                    currentResource.resourceFiles!);
                              },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            Icon(Icons.download_rounded, size: 28),

                            SizedBox(width: 8),

                            Text(
                              'Download Files',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}
