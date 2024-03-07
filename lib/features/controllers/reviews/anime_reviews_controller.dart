import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AnimeReviewsController extends GetxController{
  static AnimeReviewsController get instance => Get.find();

  final animeId = Get.arguments["animeId"];

  final ScrollController scrollController = ScrollController();
  bool hasMore = true;
  int _currentPage = 1;
  final Rx<bool> isLoading = true.obs;

  final RxList reviews = [].obs;

  final Rx<bool> showSpoilers = false.obs;
  final Rx<bool> showPreliminary = false.obs;

  @override
  onReady(){
    getAnimeReviews(animeId);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(hasMore){
          fetchNextReviews();
        }
      }
    });

    super.onReady();

  }

  void getAnimeReviews(int animeId) async{
    final url = "anime/$animeId/reviews?spoiler=${showSpoilers.value}&preliminary=${showPreliminary.value}&page=$_currentPage";

    try{
      if(_currentPage == 1){
        isLoading.value = true;
      }
      final response = (await ApiService.instance.get(url));
      reviews.addAll(response["data"]);
      hasMore = response["pagination"]["has_next_page"];
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  void fetchNextReviews(){
    _currentPage++;
    getAnimeReviews(animeId);
  }

  void filterReview(){
    if(showSpoilers.value || showPreliminary.value){
      _currentPage = 1;
      reviews.clear();
      getAnimeReviews(animeId);
    }
  }
}