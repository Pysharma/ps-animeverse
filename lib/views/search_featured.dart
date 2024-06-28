import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../api/get_anime_by_ranking_type_api.dart';
import '../core/screens/error_screen.dart';
import '../core/widgets/loader.dart';
import '../screens/anime_details_screen.dart';
import '../screens/view_all_animes_screen.dart';
import '../widgets/anime_tile.dart';

class SearcgFeaturedAnimes extends StatelessWidget {
  const SearcgFeaturedAnimes({
    super.key,
    required this.rankingType,
    required this.label,
  });

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeByRankingTypeApi(rankingType: rankingType, limit: 20),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final animes = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Title part
                Text(
                  textAlign: TextAlign.center,
                  label+" Suggestions",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 30,),

                SizedBox(
                  height: 850,
                  child: MasonryGridView.builder(
                    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: animes!.length,
                    itemBuilder: (context, index) {
                      final anime = animes.elementAt(index);

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AnimeDetailsScreen.routeName,
                            arguments: anime.node.id,
                          );
                        },
                        child: AnimeTile(
                          anime: anime.node,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
