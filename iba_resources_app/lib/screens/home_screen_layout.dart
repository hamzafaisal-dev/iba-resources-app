import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:iba_resources_app/constants/dropdown_items.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';
import 'package:iba_resources_app/services/navigation_service.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/filter_chip.dart';
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

  late String? _filterYear = '';
  late String? _filterResourceType = '';
  late String? _filterSemester = '';

  late ResourceBloc _resourceBloc;
  late UserModel? _authenticedUser;

  void _searchByName(String searchedName) {
    if (searchedName == '') return;

    _resourceBloc.add(FetchSearchedResources(searchedName));
  }

  void _clearSearch() {
    if (_searchBarController.text.isEmpty) return;

    _searchBarController.clear();

    _resourceBloc.add(const FetchResourcesStream());
  }

  void _filterResources() {
    if (_filterYear == null &&
        _filterResourceType == null &&
        _filterSemester == null) {
      return;
    } else {
      _resourceBloc.add(FetchFilteredResources({
        "resourceType": _filterResourceType,
        "semester": _filterSemester,
        "year": _filterYear,
      }));
    }

    Navigator.of(context).pop();
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: const Color(0XFFF3F3F3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // close dialog icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Filter Resources" text
                    Text(
                      'Filter Resources',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // "Semester"
                    Text(
                      'Semester',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // semester chips
                    Wrap(
                      children: [
                        ...DropdownItems.semesterDropdownItems.map(
                          (year) => CustomFilterChip(
                            chipLabel: year,
                            onPressed: (String selectedSemester) {
                              _filterSemester = selectedSemester;

                              print(_filterSemester);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // "Resource Type"
                    Text(
                      'Resource Type',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // resource type chips
                    Wrap(
                      children: [
                        ...DropdownItems.resourceTypes.map(
                          (resourceType) => CustomFilterChip(
                            chipLabel: resourceType,
                            onPressed: (String selectedResourceType) {
                              _filterResourceType = selectedResourceType;

                              print(_filterResourceType);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // "Year"
                    Text(
                      'Year',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // years chips
                    Wrap(
                      children: [
                        ...DropdownItems.yearDropdownItems.map(
                          (year) => CustomFilterChip(
                            chipLabel: year,
                            onPressed: (String selectedYear) {
                              _filterYear = selectedYear;

                              print(_filterYear);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 190),

                    // apply filters button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        onPressed: () {
                          _filterResources();
                        },
                        child: Text(
                          'Apply Filters',
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _resourceBloc = ResourceBloc(
      resourceRepository: widget.resourceRepository,
      authBloc: BlocProvider.of<AuthBloc>(context),
    );

    final authBlocBloc = BlocProvider.of<AuthBloc>(context);

    final signUpBloc = BlocProvider.of<SignUpBloc>(context);

    if (authBlocBloc.state is AuthStateAuthenticated) {
      _authenticedUser =
          (authBlocBloc.state as AuthStateAuthenticated).authenticatedUser;
    } else if (signUpBloc.state is SignUpValidState) {
      _authenticedUser = (signUpBloc.state as SignUpValidState).newUser;
    }

    // fetch resources only if they haven't been loaded before

    if (_resourceBloc.state is! ResourcesStreamLoaded) {
      _resourceBloc.add(const FetchResourcesStream());
    }

    // _resourceBloc.add(const FetchResourcesStream());
    super.initState();
  }

  @override
  void dispose() {
    _resourceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build1 was called');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hey username
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _authenticedUser != null
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
                            text: _authenticedUser!.name,
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
                    _openFilterDialog();
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 18),
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
                      print(state);

                      if (state is ResourcesLoading) {
                        return const Center(
                          child: ScreenProgressIndicator(),
                        );
                      }

                      if (state is ResourceError) {
                        print(state.errorMsg);
                        return Text(state.errorMsg);
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

                              if (snapshot.hasError) {
                                return const Text(
                                  'Cannot not fetch data at this time',
                                );
                              }

                              if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return const Text(
                                    'Could not find what you were looking for',
                                  );
                                }

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
