import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class AnimeSearchController extends GetxController{
  static AnimeSearchController get instance => Get.find();

  AnimeSearchController({this.fetchFirstTime=true});
  final bool fetchFirstTime;

  TextEditingController searchController = TextEditingController();

  RxList studios = [].obs;
  RxList animeList = [].obs;
  RxList genres = [].obs;

  Rx<bool> isLoading = true.obs;
  int _currentPage = 1;
  bool _hasMore = false;
  Rx<bool> showClearBtn = false.obs;
  Rx<int> selectedSortOption = 0.obs;
  String _orderBy = "start_date";
  String _sort = "desc";

  final ScrollController scrollController = ScrollController();

  RxList selectedStatusOptions = [].obs;
  RxList selectedTypeOptions = [].obs;
  RxList selectedAgeOptions = [].obs;
  RxList selectedYearOptions = [].obs;
  RxList selectedStudioOptions = [].obs;
  RxList selectedGenreOptions = [].obs;

  String typeQuery = "";
  String statusQuery = "";
  String ageQuery = "";
  String genreQuery = "";

  void getAnimeList() async{
    try {
      if (_currentPage == 1) {
        isLoading.value = true;
      }
      final String query = searchController.text.trim();

      final String url = 'anime?q=$query&$typeQuery&$statusQuery&$genreQuery&order_by=$_orderBy&sort=$_sort&page=$_currentPage&limit=24';
      final response = await ApiService.instance.get(url);
      animeList.addAll(response["data"]);
      _hasMore = response["pagination"]["has_next_page"];
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          fetchNextData();
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    if(fetchFirstTime){
      getAnimeList();
    }
    initialize();
    super.onReady();
  }

  void initialize(){
    fetchStudios();
    fetchGenres();
  }

  void fetchStudios()async{
    final response = await ApiService.instance.get("producers");
    studios.addAll(response["data"]);
    studios.sort((a,b)=>a["titles"][0]["title"].compareTo(b["titles"][0]["title"]));
  }

  void fetchGenres() async{
    final response = await ApiService.instance.get("genres/anime");
    genres.addAll(response["data"]);
  }

  void searchAnime() {
    final query = searchController.text.trim();
    if(query.isNotEmpty){
      animeList.clear();
      _currentPage = 1;
      _hasMore = true;
      getAnimeList();
    }
  }

  void fetchNextData(){
    _currentPage++;
    getAnimeList();
  }

  void onQueryChange(){
    if(searchController.text.isNotEmpty){
      showClearBtn.value = true;
    }
    else{
      showClearBtn.value = false;
    }
  }

  void sortAnime(){
    _currentPage = 1;
    animeList.clear();
    getAnimeList();
  }

  void clearQuery(){
    if(searchController.text.isNotEmpty){
      searchController.clear();
      animeList.clear();
      _currentPage = 1;
      getAnimeList();
    }
  }

  void selectSortOption(int value){
    selectedSortOption.value = value;
    if(value == 0){
      _orderBy = "start_date";
      _sort = "desc";
    }
    else if(selectedSortOption.value == 1){
      _orderBy = "start_date";
      _sort = "asc";
    }
    else{
      _orderBy = "title";
      _sort = "asc";
    }
  }

  void filterAnime({bool hasBack=false}){
    typeQuery = "type=${selectedTypeOptions.join("&type=")}";
    statusQuery = "status=${selectedStatusOptions.join("&status=")}";
    genreQuery = "genres=${selectedGenreOptions.join("&genres=")}";

    animeList.clear();
    _currentPage = 1;
    getAnimeList();

    if(hasBack){
      Get.back();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}