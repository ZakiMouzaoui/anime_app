import 'package:anime_app/common/controllers/drawer_controller.dart';
import 'package:anime_app/features/anime/screens/anime_list/animes.dart';
import 'package:anime_app/features/anime/screens/latest_anime/latest_anime.dart';
import 'package:anime_app/features/anime/screens/popular_characters/popular_characters.dart';
import 'package:anime_app/features/anime/screens/rankings/rankings.dart';
import 'package:anime_app/features/anime/screens/schedules/anime_schedules.dart';
import 'package:anime_app/features/anime/screens/seasons/seasons.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget(
      {super.key,
      this.onTap,
      required this.icon,
      required this.title,
      required this.index, this.iconSize});

  final VoidCallback? onTap;
  final IconData icon;
  final String title;
  final int index;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final controller = GetxDrawerController.instance;

    return Obx(
        (){
          final isSelected = controller.currentIndex.value == index;
          return Material(
            color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
            child: InkWell(
                onTap: onTap ?? (){
                  controller.currentIndex.value = index;
                  switch(index){
                    case 0:
                      Get.off(()=>const LatestAnime());
                    case 1:
                      Get.off(()=>const AnimeList());
                    case 2:
                      Get.off(()=>const Seasons());
                    case 3:
                      Get.off(()=>const Rankings());
                    case 8:
                      Get.off(()=>const PopularCharacters());
                    case 9:
                      Get.off(()=>const Recommendations());
                    case 10:
                      Get.off(()=>const AnimeSchedules());
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(children: [
                    Icon(
                      icon,
                      color: isSelected ? Colors.blue : null,
                      size: iconSize,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isSelected ? Colors.blue : Colors.white.withOpacity(0.9)),
                    ),
                  ]),
                )),
          );
        },
    );
  }
}
