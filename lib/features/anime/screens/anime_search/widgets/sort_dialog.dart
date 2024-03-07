import 'package:anime_app/features/controllers/search/anime_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SortDialog extends StatelessWidget {
  const SortDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: const Text(
        "Sort By",
        style: TextStyle(fontSize: 20),
      ),
      content: SizedBox(
          width: 0.75.sw,
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SortRadio(value: 0, title: 'Date (Newest)'),
                SortRadio(value: 1, title: 'Date (Oldest)'),
                SortRadio(value: 2, title: 'Name')
              ],
            ),
          )),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      actions: [
        TextButton(
            onPressed: (){
              Get.find<AnimeSearchController>().sortAnime();
              Get.back();
            },
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }
}

class SortRadio extends StatelessWidget {
  const SortRadio({super.key, required this.value, required this.title});

  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeSearchController>();

    return InkWell(
        onTap: () {
          controller.selectSortOption(value);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              SizedBox(
                  width: 32.w,
                  child: Obx(() => Radio(
                        activeColor: Colors.blue,
                        value: value,
                        groupValue: controller.selectedSortOption.value,
                        onChanged: (value) {
                          controller.selectedSortOption(value);
                        }),
                  )),
              SizedBox(
                width: 16.w,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
    );
  }
}
