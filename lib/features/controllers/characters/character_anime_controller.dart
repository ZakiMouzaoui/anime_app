import 'package:anime_app/data/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CharacterAnimeController extends GetxController{
  Rx<bool> isLoading = true.obs;
  RxList<dynamic> anime = [].obs;


  void fetchCharacterAnime() async{
    try{
      final response = await ApiService.instance.get("anime");
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }
}