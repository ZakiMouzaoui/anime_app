import 'package:anime_app/common/widgets/drawer_widget.dart';
import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/recommendations/controllers/recommendations_controller.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecommendationsController());

    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshList();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Recommendations"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        drawer: const DrawerWidget(),
        body: Obx(
          () {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: KCircularProgressIndicator(),
              );
            }
            final entries = controller.recommendations;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: ListView.separated(
                controller: controller.scrollController,
                itemCount: entries.length,
                itemBuilder: (_, index) {
                  final entry = entries[index];

                  return RecommendationCard(entry: entry);
                },
                separatorBuilder: (_, __) => SizedBox(
                  height: 12.h,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
