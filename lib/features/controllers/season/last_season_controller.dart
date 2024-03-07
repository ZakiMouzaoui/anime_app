import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class LastSeasonController extends GetxController{
  final String year;
  final String season;

  LastSeasonController({required this.year, required this.season});

  Rx<bool> showVerticalGrid = true.obs;
  Rx<bool> isLoading = true.obs;
  int _currentPage = 1;
  bool _hasMore = true;

  RxList animeList = [].obs;
  final ScrollController scrollController = ScrollController();


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

      final url = "seasons/$year/$season?page=$_currentPage&limit=24";
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