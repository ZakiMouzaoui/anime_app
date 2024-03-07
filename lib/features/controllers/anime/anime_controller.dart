import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AnimeController extends GetxController{
  static AnimeController get instance => Get.find();
  int _currentPage = 1;

  late final ScrollController scrollController = ScrollController();

  final List<dynamic> animeList = [].obs;
  final Rx<bool> isLoading = false.obs;
  final apiService = ApiService.instance;
  Rx<bool> showVerticalGrid = true.obs;
  bool hasMore = true;

  @override
  onInit(){
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(hasMore){
          fetchNextAnime();
        }
      }
    });
    getAnimeList();
    super.onInit();
  }

  Future<void> getAnimeList() async{
    final url = "anime?order_by=title&page=$_currentPage&limit=24";

    try{
      if(_currentPage == 1){
        isLoading.value = true;
      }

      final response = await Get.put(ApiService()).get(url);
      animeList.addAll(response["data"]);
      hasMore = response["pagination"]["has_next_page"];
    }catch(e){
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    finally{
      isLoading.value = false;
    }
  }

  void fetchNextAnime(){
      _currentPage++;
      getAnimeList();
  }

  void refreshList(){
    _currentPage = 1;
    getAnimeList();
  }

  void toggleGridView(){
    showVerticalGrid.toggle();
    //currentOffset.value = scrollController.offset;
  }
}