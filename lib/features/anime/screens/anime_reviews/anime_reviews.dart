import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/anime_reviews/widgets/anime_review_tile.dart';
import 'package:anime_app/features/anime/screens/anime_reviews/widgets/reviews_filter_dialog.dart';
import 'package:anime_app/features/controllers/reviews/anime_reviews_controller.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AnimeReviews extends StatelessWidget {
  const AnimeReviews({super.key, required this.animeId});

  final int animeId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimeReviewsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        actions: [
          IconButton(onPressed: (){
            showAdaptiveDialog(
                useSafeArea: true,
                context: context,
                builder: (_)=> const ReviewsFilterDialog()
            );
          }, icon: const Icon(Icons.filter_list_rounded,color: Colors.white54,))
        ],
      ),
      body: Obx((){
        if(controller.isLoading.isTrue){
          return const Center(
            child: KCircularProgressIndicator(),
          );
        }
        if(controller.reviews.isNotEmpty){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: ListView.separated(
              controller: controller.scrollController,
                itemBuilder: (_,index){
                  final review = controller.reviews[index];
                  return AnimeReviewTile(review: review);
                },
                separatorBuilder: (_,__)=>const Divider(color: KColors.darkerGrey,),
                itemCount: controller.reviews.length
            ),
          );
        }
        return const Center(
          child: Text("No data found"),
        );
      })
    );
  }
}
