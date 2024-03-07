import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SearchCharactersController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxList characters = [].obs;
  Rx<bool> isLoading = true.obs;
  int _currentPage = 1;
  bool _hasMore = false;
  Rx<bool> showClearBtn = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getCharacters("");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_hasMore && _currentPage < 20) {
          fetchNextData();
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    print("ready");
    super.onReady();
  }

  void getCharacters(String query) async {
    try {
      if (_currentPage == 1) {
        isLoading.value = true;
      }
      final url = query.isNotEmpty
          ? 'characters?q=$query&page=$_currentPage&order_by=favorites&sort=desc'
          : 'characters?page=$_currentPage&order_by=favorites&sort=desc';
      final response = await ApiService.instance.get(url);
      characters.addAll(response["data"]);
      _hasMore = response["pagination"]["has_next_page"];
      isLoading.value = false;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  void fetchNextData() {
    _currentPage++;
    getCharacters(searchController.text.trim());
  }

  void searchCharacters() {
    final query = searchController.text.trim();
    if(query.isNotEmpty){
      characters.clear();
      _currentPage = 1;
      _hasMore = true;
      getCharacters(query);
    }
  }

  void onQueryChange(){
    if(searchController.text.isNotEmpty){
      showClearBtn.value = true;
    }
    else{
      showClearBtn.value = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
