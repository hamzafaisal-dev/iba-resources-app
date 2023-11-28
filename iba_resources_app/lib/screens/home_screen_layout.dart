import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key});

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  final _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Hey username
        Padding(
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
                  text: 'Farhan',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
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
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
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
                  onPressed: () {},
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

        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 1200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                const Text(
                  'Latest Uploads ⚡',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 18),

                // resource container
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
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

                      // resource title
                      const Text(
                        'The quick brown fox jumps over the lazy dog',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 246, 246, 246),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // resource description
                      const Text(
                        'The quick brown fox jumps over the lazy dogfdgf...',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 246, 246, 246),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // resource type + likes/dislikes buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // resource type
                          const Chip(
                            label: Text(
                              'Quiz',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            backgroundColor: Colors.white,
                          ),

                          // likes + dislikes
                          Row(
                            children: [
                              // likes button
                              const Chip(
                                backgroundColor: Colors.white,
                                label: Row(
                                  children: [
                                    //
                                    Text(
                                      '743',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    SizedBox(width: 4),

                                    FaIcon(
                                      FontAwesomeIcons.thumbsUp,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),

                              const SizedBox(width: 8),

                              // dislikes button
                              Chip(
                                backgroundColor: Colors.white,
                                label: Row(
                                  children: [
                                    //
                                    const Text(
                                      '22',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    const SizedBox(width: 4),

                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(3.14),
                                      child: const FaIcon(
                                        FontAwesomeIcons.thumbsDown,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 8),

                      // pfp + name + save button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          const Row(
                            children: [
                              //
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage('assets/avatar.png'),
                              ),

                              SizedBox(width: 4),

                              Text(
                                'Harry Potter',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          Transform.scale(
                            scale: 2.6,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcATop,
                              ),
                              child: Lottie.asset(
                                'assets/Bookmark.json',
                                width: 20,
                                repeat: false,
                                frameRate: FrameRate(420),
                              ),
                            ),
                          ),

                          // FaIcon(FontAwesomeIcons.bookmark)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
