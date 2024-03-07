import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/controllers/anime/anime_app_bar_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AnimeDetailsController extends GetxController{
  static AnimeDetailsController get instance => Get.find();

  @override
  onReady(){
    final controller = AnimeAppBarController.instance;
    controller.showDetails.value = true;
    controller.showEpisode.value = false;
    super.onReady();
  }

  Future<List> getAnimeRecommendations(String id) async{
    try{
      var response = await ApiService.instance.get("anime/$id/recommendations?limit=5");
      return response["data"].take(5).toList();
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<List> getAnimeRelations(int id) async{
    try{
      var response = await ApiService.instance.get("anime/$id/relations");
      return response["data"];
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }
}