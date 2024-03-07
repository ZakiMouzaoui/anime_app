import 'package:anime_app/common/widgets/drawer_widget.dart';
import 'package:anime_app/features/anime/screens/anime_search/anime_search.dart';
import 'package:anime_app/features/anime/screens/seasons/widgets/current_season_tab.dart';
import 'package:anime_app/features/anime/screens/seasons/widgets/last_season_tab.dart';
import 'package:anime_app/features/anime/screens/seasons/widgets/next_season_tab.dart';
import 'package:anime_app/features/anime/screens/seasons/widgets/other_seasons_tab.dart';
import 'package:anime_app/features/controllers/season/anime_season_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class Seasons extends StatefulWidget {
  const Seasons({super.key});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimeSeasonController());

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Seasons"),
          actions: [
            IconButton(onPressed: ()=>Get.to(()=>const AnimeSearch()), icon: const Icon(Icons.search_rounded)),
            Obx(() => IconButton(onPressed: ()=>controller.showVerticalGrid.toggle(), icon: Icon(controller.showVerticalGrid.isFalse ? Icons.apps_rounded : Icons.list)))
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            tabs: const [
              Text("Last Season"),
              Text("Current Season"),
              Text("Next Season"),
              Text("Other Seasons")
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: const TabBarView(
          children: [
            LastSeasonTab(),
            CurrentSeasonTab(),
            NextSeasonTab(),
            OtherSeasonsTab()
          ],
        ),
      ),
    );
  }
}
