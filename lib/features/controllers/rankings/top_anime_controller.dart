import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class TopAnimeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  Rx<bool> isLoading = true.obs;
  RxList animeList = [].obs;
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void onInit() {
    getAnimeList();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(_hasMore){
          fetchNextData();
        }
      }
    });
    super.onInit();
  }

  void getAnimeList() async{
    try{
      if(_currentPage==1){
        isLoading.value = true;
      }

      final url = "top/anime?page=$_currentPage&limit=24";
      final response = await ApiService.instance.get(url);
      animeList.addAll(response["data"]);
      _hasMore = response["pagination"]["has_next_page"];
      isLoading.value = false;
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  void fetchNextData(){
    _currentPage++;
    getAnimeList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
