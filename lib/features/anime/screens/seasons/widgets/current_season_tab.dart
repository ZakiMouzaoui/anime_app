import 'package:anime_app/features/anime/screens/seasons/widgets/season_header_widget.dart';
import 'package:anime_app/features/controllers/season/anime_season_controller.dart';
import 'package:anime_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../../common/widgets/kcircular_progress_indicator.dart';
import '../../../../../common/widgets/vertical_anime_card.dart';

class CurrentSeasonTab extends StatelessWidget {
  const CurrentSeasonTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeSeasonController>();
    final seasonAndYear = KHelperFunctions.getSeason(DateTime.now()).split(' ');
    final season = seasonAndYear[0];
    final year = seasonAndYear[1];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }

          final moviesList = controller.animeList;
          final len = moviesList.length;

          return Column(
            children: [
              SeasonHeaderWidget(season: season, year: year),
              Expanded(
                  child: controller.showVerticalGrid.isTrue
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          controller: controller.scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: len,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0.w,
                                  mainAxisSpacing: 4.h,
                                  mainAxisExtent: 245.h),
                          itemBuilder: (_, index) {
                            final anime = moviesList[index];
                            return VerticalAnimeCard(
                              anime: anime,
                            );
                          })
                      : ListView.separated(
                          controller: controller.scrollController,
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            final anime = moviesList[index];
                            return HorizontalAnimeCard(anime: anime);
                          },
                          separatorBuilder: (_, __) => SizedBox(
                                height: 8.h,
                              ),
                          itemCount: len))
            ],
          );
        },
      ),
    );
  }
}
