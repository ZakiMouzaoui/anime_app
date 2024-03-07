import 'package:anime_app/features/controllers/reviews/anime_reviews_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ReviewsFilterDialog extends StatelessWidget {
  const ReviewsFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AnimeReviewsController.instance;

    return AlertDialog(
      title: const Text("Filter reviews", style: TextStyle(
        fontSize: 18,
      ),),
      titlePadding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 8.h
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 24.w, height: 24.h, child:  Obx(() => Checkbox(value: controller.showPreliminary.value, onChanged: (_){
                controller.showPreliminary.toggle();
              }))),
              SizedBox(width: 8.w,),
              const Text("Show preliminary reviews")
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            children: [
              SizedBox(width: 24.w, height: 24.h, child: Obx(() => Checkbox(value: controller.showSpoilers.value, onChanged: (_){
                controller.showSpoilers.toggle();
              }))),
              SizedBox(width: 8.w,),
              const Text("Show spoilers")
            ],
          )
        ],
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      actions: [
        SizedBox(
          height: 40.h,
          child: TextButton( onPressed: (){
            controller.filterReview();
            Get.back();
          }, style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              )
          ), child: const Text("Okay"),),
        )
      ],
    );
  }
}
