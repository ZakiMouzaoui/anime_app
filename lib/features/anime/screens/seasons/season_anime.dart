import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/controllers/season/anime_season_controller.dart';
import 'package:anime_app/features/controllers/season/other_anime_season_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../common/widgets/vertical_anime_card.dart';

class SeasonAnime extends StatelessWidget {
  const SeasonAnime({super.key, required this.season, required this.year});

  final String season;
  final String year;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeSeasonController>();
    final otherSeasonCtr =
        Get.put(OtherAnimeSeasonController(year: year, season: season));

    return Scaffold(
        appBar: AppBar(
          title: Text("$season $year"),
        ),
        body: Obx(() {
          if (otherSeasonCtr.isLoading.isTrue) {
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          final animeList = otherSeasonCtr.animeList;
          final len = animeList.length;

          if (controller.showVerticalGrid.isTrue) {
            return GridView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                controller: otherSeasonCtr.scrollController,
                padding: EdgeInsets.zero,
                itemCount: len,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.w,
                    mainAxisSpacing: 4.h,
                    mainAxisExtent: 245.h),
                itemBuilder: (_, index) {
                  final anime = animeList[index];
                  return VerticalAnimeCard(
                    anime: anime,
                  );
                });
          }
          return ListView.separated(
              controller: otherSeasonCtr.scrollController,
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final anime = animeList[index];
                return HorizontalAnimeCard(anime: anime);
              },
              separatorBuilder: (_, __) => SizedBox(
                    height: 8.h,
                  ),
              itemCount: len);
        }));
  }
}
