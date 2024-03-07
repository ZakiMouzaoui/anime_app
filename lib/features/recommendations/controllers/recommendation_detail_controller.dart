import 'package:anime_app/data/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RecommendationDetailController extends GetxController{
  Future<dynamic> getUserDetails(String username) async{
    try{
      return ApiService.instance.get("users/$username/full");
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}