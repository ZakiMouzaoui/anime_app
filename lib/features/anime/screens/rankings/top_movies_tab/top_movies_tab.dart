import 'package:anime_app/features/controllers/rankings/top_movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../../common/widgets/kcircular_progress_indicator.dart';
import '../../../../../common/widgets/vertical_anime_card.dart';
import '../../../../controllers/rankings/anime_ranking_controller.dart';

class TopMoviesTab extends StatelessWidget {
  const TopMoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopMoviesController());
    final rankingCtr = Get.find<AnimeRankingController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }

          final moviesList = controller.moviesList;
          final len = moviesList.length;

          if (rankingCtr.showVerticalGrid.isTrue) {
            return GridView.builder(
                shrinkWrap: true,
                controller: controller.scrollController,
                padding: EdgeInsets.zero,
                itemCount: len,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.w,
                    mainAxisSpacing: 4.h,
                    mainAxisExtent: 245.h),
                itemBuilder: (_, index) {
                  final anime = moviesList[index];
                  return VerticalAnimeCard(
                    anime: anime,
                  );
                });
          } else {
            return ListView.separated(
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
                itemCount: len);
          }
        },
      ),
    );
  }
}
