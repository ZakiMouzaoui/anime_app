import 'package:anime_app/features/anime/screens/seasons/season_anime.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SeasonsOptions extends StatelessWidget {
  const SeasonsOptions({super.key, required this.year, required this.seasons});

  final int year;
  final List seasons;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "$year",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      SizedBox(
        height: 32.h,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final season = seasons[index].toString().capitalize;

              return InkWell(
                onTap: ()=>Get.to(()=>SeasonAnime(season: season!, year: '$year')),
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: KColors.darkContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                        seasons[index].toString().capitalize!,
                        style: const TextStyle(color: Colors.white70),
                      )),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(
                  width: 16.w,
                ),
            itemCount: seasons.length),
      )
      /*
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(seasons.length, (index) => Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: KColors.darkContainer,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(seasons[index]),
              ),
            )),
          )
           */
    ]);
  }
}
