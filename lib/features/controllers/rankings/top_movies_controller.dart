import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class TopMoviesController extends GetxController{
  final ScrollController scrollController = ScrollController();

  Rx<bool> isLoading = true.obs;
  RxList moviesList = [].obs;
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void onInit() {
    getMoviesList();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(_hasMore){
          fetchNextData();
        }
      }
    });
    super.onInit();
  }

  void getMoviesList() async{
    try{
      if(_currentPage==1){
        isLoading.value = true;
      }

      final url = "top/anime?type=movie&page=$_currentPage&limit=24";
      final response = await ApiService.instance.get(url);
      moviesList.addAll(response["data"]);
      _hasMore = response["pagination"]["has_next_page"];
      isLoading.value = false;
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  void fetchNextData(){
    _currentPage++;
    getMoviesList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}