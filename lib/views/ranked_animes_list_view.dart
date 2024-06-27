import 'package:flutter/material.dart';
import '../common/styles/paddings.dart';
import '../models/anime.dart';
import '../widgets/anime_list_tile.dart';

class RankedAnimesListView extends StatelessWidget {
  const RankedAnimesListView({
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