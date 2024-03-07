import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/controllers/schedule/anime_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/horizontal_anime_card.dart';
import '../../../../common/widgets/vertical_anime_card.dart';

class DaySchedule extends StatelessWidget {
  const DaySchedule({super.key, required this.day});

  final String day;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimeScheduleController(day), tag: day);
    return Scaffold(
        appBar: AppBar(
          title: Text(day.capitalize!),
          actions: [
            IconButton(onPressed: controller.showVerticalGrid.toggle, icon: Obx(()=>controller.showVerticalGrid.isTrue ? const Icon(Icons.list_rounded) : const Icon(Icons.apps_rounded)))
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
              if(controller.showVerticalGrid.isTrue){
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
              }
              return ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final anime = animeList[index];
                    return HorizontalAnimeCard(anime: anime);
                  },
                  separatorBuilder: (_, __) => SizedBox(
                    height: 8.h,
                  ),
                  itemCount: animeList.length);

            },
          ),
        ));
  }
}
