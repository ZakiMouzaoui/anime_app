import 'package:get/get.dart';

class AnimeAppBarController extends GetxController{
  static AnimeAppBarController get instance => Get.find();

  Rx<bool> showDetails = true.obs;
  Rx<bool> showEpisode = false.obs;

  void showDetailsTab(){
    showDetails.value = true;
    showEpisode.value = false;
  }

  void showEpTab(){
    showDetails.value = false;
    showEpisode.value = true;
  }

  void hideIcons(){
    showDetails.value = false;
    showEpisode.value = false;
  }
}