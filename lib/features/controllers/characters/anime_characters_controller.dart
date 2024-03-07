import 'package:anime_app/data/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AnimeCharactersController extends GetxController{
  Future<dynamic> getAnimeCharacters(String animeId) async{
    try{
      return ApiService.instance.get("anime/$animeId/characters");
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> getAnimeStaffs(String animeId) async{
    try{
      return ApiService.instance.get("anime/$animeId/staff");
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}