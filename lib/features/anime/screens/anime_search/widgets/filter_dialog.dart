import 'package:anime_app/features/anime/screens/anime_search/widgets/filter_options_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/search/anime_search_controller.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeSearchController>();

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: const Text(
        "Filter By?",
        style: TextStyle(fontSize: 20),
      ),
      content: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          width: 0.9.sw,
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FilterOptionsList(
                  title: "Status",
                  options: const {"airing": "Airing", "complete": "Finished", "upcoming": "Upcoming"},
                  selectedOptions: controller.selectedStatusOptions,
                ),
                SizedBox(height: 16.h,),
                FilterOptionsList(
                  title: "Type",
                  options: const {"tv": "TV", "movie": "Movie", "ona": "ONA", "ova": "OVA", "tv_special": "Special"},
                  selectedOptions: controller.selectedTypeOptions,
                ),
                SizedBox(height: 16.h,),
                FilterOptionsList(
                  title: "Age",
                  options: const {"pg13": "13+", "r17": "17+", "g": "All ages"},
                  selectedOptions: controller.selectedAgeOptions,
                ),
                SizedBox(height: 16.h,),
                FilterOptionsList(
                  isDropdown: true,
                  title: "Year",
                  isOpen: false,
                  width: 70.w,
                  options: Map.fromIterable(List.generate(2026-1927,  (index) => '${2025-index}')),
                  selectedOptions: controller.selectedYearOptions,
                ),
                FilterOptionsList(
                  isDropdown: true,
                  title: "Studio",
                  isOpen: false,
                  options: { for (var data in controller.studios) data["mal_id"].toString() : data["titles"][0]["title"] },
                  selectedOptions: controller.selectedStudioOptions,
                ),
                FilterOptionsList(
                    isDropdown: true,
                    title: "Genre",
                    isOpen: true,
                    options: { for (var data in controller.genres) data["mal_id"].toString() : data["name"] },
                    selectedOptions: controller.selectedGenreOptions
                )
              ],
            ),
          )),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      scrollable: true,
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.blue),
            )),
        TextButton(
            onPressed: () {
              Get.find<AnimeSearchController>().filterAnime(hasBack: true);
            },
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.blue),
            )),
      ],
    );
  }
}
