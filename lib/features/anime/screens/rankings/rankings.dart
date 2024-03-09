import 'package:anime_app/common/widgets/drawer_widget.dart';
import 'package:anime_app/features/anime/screens/anime_search/anime_search.dart';
import 'package:anime_app/features/anime/screens/rankings/top_airing_tab/top_airing_tab.dart';
import 'package:anime_app/features/anime/screens/rankings/top_anime_tab/top_anime.dart';
import 'package:anime_app/features/anime/screens/rankings/top_movies_tab/top_movies_tab.dart';
import 'package:anime_app/features/controllers/rankings/anime_ranking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class Rankings extends StatefulWidget {
  const Rankings({super.key});

  @override
  State<Rankings> createState() => _RankingsState();
}

class _RankingsState extends State<Rankings> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 3, vsync: this);
    final controller = Get.find<AnimeRankingController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Rankings"),
          actions: [
            IconButton(onPressed: ()=>Get.to(()=>const AnimeSearch()), icon: const Icon(Icons.search_rounded)),
            Obx(() => IconButton(onPressed: ()=>controller.showVerticalGrid.toggle(), icon: Icon(controller.showVerticalGrid.isFalse ? Icons.apps_rounded : Icons.list)))
          ],
          bottom: TabBar(
            controller: tabController,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            tabs: const [
              Text("Top Anime"),
              Text("Top Airing"),
              Text("Top Movies")
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: TabBarView(
          controller: tabController,
          children: const [
            TopAnimeTab(),
            TopAiringTab(),
            TopMoviesTab()
          ],
        ),
    );
  }
}
