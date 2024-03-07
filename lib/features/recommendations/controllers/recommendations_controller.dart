import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RecommendationsController extends GetxController{
  int _currentPage = 1;
  bool _hasMore = true;
  RxList recommendations = [].obs;
  Rx<bool> isLoading = true.obs;

  final ScrollController scrollController = ScrollController();

  @override
  onInit(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
          if(_hasMore){
            _currentPage++;
            getAnimeRecommendations();
          }
      }
    });
    getAnimeRecommendations();
    super.onInit();
  }

  void getAnimeRecommendations() async{
    try{
      final response = await ApiService.instance.get("recommendations/anime?page=$_currentPage");
      recommendations.addAll(response["data"]);
      _hasMore = response["pagination"]["has_next_page"];
      isLoading.value = false;
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  void refreshList(){
    recommendations.clear();
    _currentPage = 1;
    isLoading.value = true;
    getAnimeRecommendations();
  }
}