import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_metadata.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_recommendations.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_reviews_row.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_synopsis.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_trailer_thumbnail.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/related_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTab extends StatefulWidget {
  const DetailsTab({super.key, required this.animeId});

  final int animeId;

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
        future: ApiService.instance.get("anime/${widget.animeId}/full"),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          final Map<String, dynamic> anime = snapshot.data!["data"];
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Meta data
                    AnimeMetaData(anime: anime),
                    SizedBox(
                      height: 12.h,
                    ),

                    /// Reviews
                    AnimeReviewsRow(anime: anime),
                    SizedBox(
                      height: 8.h,
                    ),

                    /// Synopsis and Tags
                    AnimeSynopsis(anime: anime),

                    if (anime["trailer"]["youtube_id"] != null)

                      /// Trailer
                      AnimeTrailerThumbnail(anime: anime),

                    /// Related
                    if (anime["relations"].isNotEmpty)
                      RelatedAnime(
                        animeId: anime["mal_id"],
                        cover: anime["images"]["jpg"]["image_url"],
                        relations: anime["relations"],
                      ),

                    /// Recommendations
                    AnimeRecommendations(animeId: '${anime["mal_id"]}'),
                  ]),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
