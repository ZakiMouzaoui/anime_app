import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_metadata.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_recommendations.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_reviews_row.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_synopsis.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/anime_trailer_thumbnail.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/related_anime.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTab extends StatefulWidget {
  const DetailsTab({super.key, required this.animeId});

  final int animeId;

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab>{

  late final query = Query(key: "anime/${widget.animeId}", queryFn: ()=>ApiService.instance.get("anime/${widget.animeId}/full"));

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
        query: query,
        builder: (_,state){
      if(state.status == QueryStatus.initial || state.status == QueryStatus.loading){
        return const Center(
          child: KCircularProgressIndicator(),
        );
      }
      final Map<String, dynamic> anime = state.data!["data"];
      return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: 200.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            anime["images"]["jpg"]["image_url"]
                        ),
                        fit: BoxFit.fitWidth
                    )
                )
            ),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  KColors.primary,
                  KColors.primary.withOpacity(0.8)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
            ),
            Container(
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
          ],
        ),
      );
    });
  }
}
