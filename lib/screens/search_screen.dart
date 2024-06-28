import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../views/featured_animes.dart';
import '../views/search_featured.dart';
import '/api/get_anime_by_search_api.dart';
import '/common/styles/paddings.dart';
import '/models/anime.dart';
import '/models/anime_node.dart';
import '/widgets/anime_list_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search for Animes'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              InkWell(
                onTap: () {
                  showSearch(context: context, delegate: AnimeSearchDelegate());

                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 70,
                    color: Colors.grey[300],
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
                        child: Row(
                          children: [
                            Icon(Icons.search_outlined),
                            SizedBox(width: 10,),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              SearcgFeaturedAnimes(
                rankingType: 'bypopularity',
                label: 'Top Popular',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimeSearchDelegate extends SearchDelegate<List<AnimeNode>> {
  Iterable<Anime> animes = [];

  Future searchAnime(String query) async {
    final animes = await getAnimesbySearchApi(query: query);

    this.animes = animes.toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchAnime(query);
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Lottie.asset(
          'assets/search_screen.json',
          width: 340,
          height: 340,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return FutureBuilder<Iterable<Anime>>(
        future: getAnimesbySearchApi(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final animes = snapshot.data ?? [];
            return SearchResultsView(animes: animes);
          }
        },
      );
    }
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({
    super.key,
    required this.animes,
  });

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index);

          return AnimeListTile(
            anime: anime,
          );
        },
      ),
    );
  }
}