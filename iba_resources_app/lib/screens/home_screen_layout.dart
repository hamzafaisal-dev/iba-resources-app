import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile_skeleton.dart';
import 'package:iba_resources_app/widgets/progress_indicators/screen_progress_indicator.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/skeleton_text.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key, required this.resourceRepository});

  final ResourceRepository resourceRepository;

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  final _searchBarController = TextEditingController();

  late ResourceBloc _resourceBloc;

  void _searchByName(String searchedName) {
    if (searchedName == '') return;

    _resourceBloc.add(FetchSearchedResources(searchedName));
  }

  void _clearSearch() {
    if (_searchBarController.text.isEmpty) return;

    _searchBarController.clear();

    _resourceBloc.add(const FetchResources());
  }

  @override
  void initState() {
    _resourceBloc = ResourceBloc(
      resourceRepository: widget.resourceRepository,
      authBloc: BlocProvider.of<AuthBloc>(context),
    );

    // _resourceBloc.add(const FetchResources());

    _resourceBloc.add(const FetchResourcesStream());
    super.initState();
  }

  @override
  void dispose() {
    _resourceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hey username
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: state is AuthStateAuthenticated
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hey ',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          TextSpan(
                            text: state.authenticatedUser.name,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : AnimatedSkeletonText(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.8,
                      borderRadius: BorderRadius.circular(10),
                    ),
            );
          },
        ),

        const SizedBox(height: 10),

        // Start exploring
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Start exploring resources',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),

        const SizedBox(height: 18),

        // search bar + filter button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              // search bar
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  // const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _searchByName(_searchBarController.text);
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchBarController,
                          decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 4),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _clearSearch,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // filter button
              Container(
                width: 53.5,
                height: 53.5,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    // BlocProvider.of<ResourceBloc>(context).add(
                    //   FetchSearchedResources('Theory'),
                    // );

                    // _resourceBloc.add(
                    //   FetchSearchedResources('Theory'),
                    // );
                  },
                  icon: Icon(
                    Icons.filter_alt_sharp,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // all resources container
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Latest Uploads
                  const Text(
                    'Latest Uploads ⚡',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 18),

                  BlocBuilder(
                    bloc: _resourceBloc,
                    builder: (BuildContext context, ResourceState state) {
                      if (state is ResourcesLoading) {
                        // return ListView.builder(
                        //   itemCount: 10,
                        //   itemBuilder: (context, index) =>
                        //       const ResourceTileSkeleton(),
                        // );
                      }

                      if (state is ResourceError) {
                        print(state.errorMsg);
                        return Text(state.errorMsg);
                      }

                      if (state is ResourceEmpty) {
                        return const Text(
                            'Could not find what you were looking for');
                      }

                      if (state is ResourcesStreamLoaded) {
                        return Expanded(
                          child: StreamBuilder(
                            stream: state.resources,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) =>
                                      const ResourceTileSkeleton(),
                                );
                              }

                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    List<ResourceModel> resourceData =
                                        snapshot.data!;
                                    var resourceObject = resourceData[index];

                                    return InkWell(
                                      onTap: () =>
                                          NavigationService.routeToNamed(
                                        '/viewResourceDetails',
                                        arguments: {
                                          'resourceObject': resourceObject
                                        },
                                      ),
                                      child: ResourceTile(
                                        resource: resourceObject,
                                      ),
                                    );
                                  },
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
