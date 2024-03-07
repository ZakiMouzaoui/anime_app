import 'package:anime_app/features/anime/screens/anime_list/animes.dart';
import 'package:anime_app/features/anime/screens/latest_anime/latest_anime.dart';
import 'package:anime_app/features/anime/screens/popular_characters/popular_characters.dart';
import 'package:anime_app/features/anime/screens/rankings/rankings.dart';
import 'package:anime_app/features/anime/screens/seasons/seasons.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/recommendations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetxDrawerController extends GetxController{
  static GetxDrawerController get instance => Get.find();

  Rx<int> currentIndex = 0.obs;

  final pages = [
    const LatestAnime(),
    const AnimeList(),
    const Seasons(),
    const Rankings(),
    Container(),
    Container(),
    Container(),
    Container(),
    const PopularCharacters(),
    const Recommendations()
  ];
}