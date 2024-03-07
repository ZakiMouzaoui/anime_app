import 'package:anime_app/data/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CharacterDetailsController extends GetxController{
  Rx<bool> isLoading = true.obs;
  RxMap character = {}.obs;

  CharacterDetailsController(this.characterId);
  final int characterId;

  @override
  void onInit() {
    getCharacterDetails();
    super.onInit();
  }

  void getCharacterDetails() async{
    try{
      final response = await ApiService.instance.get("characters/$characterId/full");
      character.value = response["data"];
      isLoading.value = false;
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }
}