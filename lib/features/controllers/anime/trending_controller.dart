import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class TrendingController extends GetxController{
   int _currentPage = 0;

  final ScrollController scrollController = ScrollController();
  final List<dynamic> animeList = [].obs;
  final Rx<bool> isLoading = false.obs;
  final Rx<bool> isLoadingMore = false.obs;
  final apiService = Get.put(ApiService());
  Rx<bool> showVerticalGrid = true.obs;
  bool hasMore = true;

  @override
  onInit(){
    getAnimeList();
    super.onInit();
  }

  Future<void> getAnimeList() async{
    final url = "trending/anime?page[limit]=10&page[offset]=${10*_currentPage}&sort=slug";

    try{
      if(_currentPage == 0){
        isLoading.value = true;
      }
      else{
        isLoadingMore.value = true;
      }

      final response = await Get.put(ApiService()).get(url);
      animeList.addAll(response["data"]);
    }catch(e){
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    finally{
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void fetchNextAnime(){
    _currentPage++;
    getAnimeList();
  }

  void refreshList(){
    _currentPage = 0;
    getAnimeList();
  }

  void toggleGridView(){
    showVerticalGrid.toggle();
  }
}