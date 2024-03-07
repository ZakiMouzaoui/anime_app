import 'package:anime_app/features/controllers/rankings/anime_ranking_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AnimeRankingController(), fenix: true);
  }
}