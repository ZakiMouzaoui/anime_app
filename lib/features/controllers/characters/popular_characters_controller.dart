import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PopularCharactersController extends GetxController{
  Rx<bool> isLoading = true.obs;
  RxList characters = [].obs;
  bool _hasMore = true;
  int _currentPage = 1;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(_hasMore){
          fetchNextData();
        }
      }
    });
    getPopularCharacters(false);
    super.onInit();
  }

  void getPopularCharacters(bool refresh) async{
    try{
      if(refresh){
        isLoading.value = true;
      }
      final response = await ApiService.instance.get("top/characters?page=$_currentPage&limit=24");
      characters.addAll(response["data"]);
      isLoading.value = false;
      _hasMore = response["pagination"]["has_next_page"];
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  void fetchNextData(){
    _currentPage ++;
    getPopularCharacters(false);
  }

  void refreshList(){
    _currentPage = 1;
    characters.clear();
    getPopularCharacters(true);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}