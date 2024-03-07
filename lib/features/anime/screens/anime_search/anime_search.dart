import 'package:anime_app/features/anime/screens/anime_search/widgets/filter_dialog.dart';
import 'package:anime_app/features/anime/screens/anime_search/widgets/sort_dialog.dart';
import 'package:anime_app/features/controllers/search/anime_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../common/widgets/kcircular_progress_indicator.dart';
import '../../../../common/widgets/vertical_anime_card.dart';
import '../../../controllers/rankings/anime_ranking_controller.dart';

class AnimeSearch extends StatelessWidget {
  const AnimeSearch({super.key, this.fetchFirstTime=true});

  final bool fetchFirstTime;

  @override
  Widget build(BuildContext context) {
    final rankingCtr = Get.find<AnimeRankingController>();
    final controller = Get.put(AnimeSearchController(fetchFirstTime: fetchFirstTime));

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: "Enter anime name...",
          ),
          textInputAction: TextInputAction.search,
          controller: controller.searchController,
          onChanged: (_) => controller.onQueryChange(),
          onFieldSubmitted: (_) => controller.searchAnime(),
        ),
        actions: [
          Obx(() {
            if (controller.showClearBtn.isTrue) {
              return IconButton(
                  onPressed: controller.clearQuery,
                  icon: const Icon(Icons.clear));
            }
            return const SizedBox();
          }),
          IconButton(
              onPressed: () => showDialog(context: context, builder: (_)=>const SortDialog()), icon: const Icon(Icons.filter_list_rounded)),
          IconButton(onPressed: ()=>showDialog(context: context, builder: (_) => const FilterDialog()), icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        child: Obx(
          () {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: KCircularProgressIndicator(),
              );
            }

            final animeList = controller.animeList;
            if (animeList.isNotEmpty) {
              if (rankingCtr.showVerticalGrid.isTrue) {
                return GridView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: animeList.length,
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
              } else {
                return ListView.separated(
                    controller: controller.scrollController,
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final anime = animeList[index];
                      return HorizontalAnimeCard(anime: anime);
                    },
                    separatorBuilder: (_, __) =>
                        SizedBox(
                          height: 8.h,
                        ),
                    itemCount: animeList.length);
              }
            }
            return const Center(child: Text("No data found"),);
          }

        ),
      ),
    );
  }
}
