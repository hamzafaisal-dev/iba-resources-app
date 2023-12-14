import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/resource_tile.dart';
import 'package:iba_resources_app/widgets/progress_indicators/screen_progress_indicator.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key, required this.resourceRepository});

  final ResourceRepository resourceRepository;

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  final _searchBarController = TextEditingController();

  late ResourceBloc _resourceBloc;

  @override
  void initState() {
    _resourceBloc = ResourceBloc(resourceRepository: widget.resourceRepository);

    _resourceBloc.add(const FetchResources());

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
              child: RichText(
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
                      text: state is AuthStateAuthenticated
                          ? state.authenticatedUser.name
                          : '...',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
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
                      const Icon(Icons.search),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchBarController,
                          decoration: const InputDecoration(
                            hintText: 'Search for resources',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
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
                    BlocProvider.of<ResourceBloc>(context).add(
                      FetchSearchedResources('Theory'),
                    );

                    _resourceBloc.add(
                      FetchSearchedResources('Theory'),
                    );
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
                        return const ScreenProgressIndicator();
                      }

                      if (state is ResourceError) {
                        print(state.errorMsg);
                        return Text(state.errorMsg);
                      }

                      if (state is ResourceEmpty) {
                        return const Text('No resources uploaded');
                      }

                      if (state is ResourcesLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.resources.length,
                            itemBuilder: (context, index) {
                              var resourceObject = state.resources[index];

                              return InkWell(
                                onTap: () => NavigationService.routeToNamed(
                                  '/viewResourceDetails',
                                  arguments: {'resourceObject': resourceObject},
                                ),
                                child: ResourceTile(
                                  resourceId: resourceObject.resourceId,
                                  resourceTitle: resourceObject.resourceTitle,
                                  resourceDescription:
                                      resourceObject.resourceDescription,
                                  uploader: resourceObject.uploader,
                                  resourceType: resourceObject.resourceType,
                                  likes: resourceObject.likes,
                                  dislikes: resourceObject.dislikes,
                                ),
                              );
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
