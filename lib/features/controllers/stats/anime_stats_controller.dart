import 'package:anime_app/data/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AnimeStatsController extends GetxController{
  Future<dynamic> getStats(String animeId) async{
    try{
      return ApiService.instance.get("anime/$animeId/statistics");
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}