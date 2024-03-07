import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class LatestAnimeController extends GetxController{
  static LatestAnimeController get instance => Get.find();
  int _currentPage = 1;
  final Rx<double> currentOffset = 0.0.obs;

  late final ScrollController scrollController = ScrollController(keepScrollOffset: true);

  final List<dynamic> animeList = [].obs;
  final Rx<bool> isLoading = false.obs;
  final apiService = Get.put(ApiService());
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
    final url = "anime?page=$_currentPage&limit=24&order_by=start_date&sort=desc";

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