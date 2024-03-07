import 'package:anime_app/features/anime/screens/anime_search/anime_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/drawer_widget.dart';
import '../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../common/widgets/kcircular_progress_indicator.dart';
import '../../../../common/widgets/vertical_anime_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../controllers/anime/latest_anime_controller.dart';


class LatestAnime extends StatelessWidget {
  const LatestAnime({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LatestAnimeController());

    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshList();
      },
      color: KColors.white,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Latest Updates"),
          actions: [
            IconButton(onPressed: ()=>Get.to(()=>const AnimeSearch()), icon: const Icon(Icons.search)),
            IconButton(
                onPressed: controller.toggleGridView,
                icon: Obx(() => Icon(controller.showVerticalGrid.isTrue
                    ? Icons.list
                    : Icons.apps_rounded)))
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
              if (controller.showVerticalGrid.isTrue) {
                return GridView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
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
                    separatorBuilder: (_, __) => SizedBox(
                      height: 8.h,
                    ),
                    itemCount: animeList.length);
              }
            },
          ),
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
