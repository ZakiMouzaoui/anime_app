import 'package:get/get.dart';

import '../anime/anime_app_bar_controller.dart';

class AnimeEpisodesController extends GetxController{
  @override
  void onReady() {
    final controller = AnimeAppBarController.instance;
    controller.showDetails.value = false;
    controller.showEpisode.value = true;
    super.onReady();
  }
}