import 'package:anime_app/common/widgets/drawer_widget.dart';
import 'package:anime_app/features/anime/screens/anime_search/anime_search.dart';
import 'package:anime_app/features/anime/screens/schedules/day_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';


class AnimeSchedules extends StatelessWidget {
  const AnimeSchedules({super.key});

  @override
  Widget build(BuildContext context) {
    final weekDays = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedules"),
        actions: [
          IconButton(onPressed: ()=>Get.to(()=>const AnimeSearch()), icon: const Icon(Icons.search_rounded))
        ],
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Center(
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: List.generate(7, (index) => InkWell(
              onTap: ()=>Get.to(()=>DaySchedule(day: weekDays[index])),
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 120.w,
                height: 35.h,
                constraints: BoxConstraints(
                  minWidth: 100.w
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: KColors.darkContainer,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Text(
                      weekDays[index].toString().capitalize!,
                      style: const TextStyle(color: Colors.white70),
                    )),
              ),
            )),
          ),
        )
      ),
    );
  }
}
