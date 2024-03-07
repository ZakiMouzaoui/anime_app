import 'package:anime_app/features/anime/screens/anime_reviews/anime_reviews.dart';
import 'package:anime_app/features/controllers/anime/anime_app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.tabController,
    required this.animeId,
  });
  //required this.animeStatus});

  final String title;
  final TabController tabController;
  final int animeId;
  //final String animeStatus;

  @override
  Widget build(BuildContext context) {
    final controller = AnimeAppBarController.instance;

    return Obx(() => AppBar(
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          actions: controller.showDetails.isTrue
              ? [
                  IconButton(
                      onPressed: () async {
                        await Get.to(() => AnimeReviews(animeId: animeId),
                            arguments: {"animeId": animeId});
                      },
                      icon: const Icon(Icons.message)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_rounded)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ]
              : controller.showEpisode.isTrue
                  ? [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.sort)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt_outlined))
                    ]
                  : [],
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            labelPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            tabs: const [
              Text("Details"),
              Text("Episodes"),
              Text("Stats"),
              Text("Characters and Staffs")
            ],
            padding: EdgeInsets.zero,
          ),
        ));
  }

  @override
  Size get preferredSize {
    final padding = MediaQuery.of(Get.context!).padding;
    return Size.fromHeight(padding.top + 16.h + kToolbarHeight);
  }
}
