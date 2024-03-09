import 'package:anime_app/common/widgets/custom_app_bar.dart';
import 'package:anime_app/features/anime/screens/details/characters_tab/characters_tab.dart';
import 'package:anime_app/features/anime/screens/details/detail_tab/details_tab.dart';
import 'package:anime_app/features/anime/screens/details/episodes_tab/episodes_tab.dart';
import 'package:anime_app/features/anime/screens/details/stats_tab/stats_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/anime/anime_app_bar_controller.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails({super.key, required this.animeTitle, required this.animeId});

  final String animeTitle;
  final int animeId;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimeAppBarController());

    final tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      final index = tabController.index;
      if (index == 0) {
        controller.showDetailsTab();
      } else if (index == 1) {
        controller.showEpTab();
      } else {
        controller.hideIcons();
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.animeTitle,
          tabController: tabController,
          animeId: widget.animeId,
          //animeStatus: status,
        ),
        body: TabBarView(
          controller: tabController,
          children:  [
            DetailsTab(animeId: widget.animeId),
            EpisodesTab(animeId: widget.animeId,),
            StatsTab(
              animeId: widget.animeId.toString(),
            ),
            CharactersTab(
              animeId: widget.animeId.toString(),
            )
          ],
        ),
      ),
    );
  }
}
