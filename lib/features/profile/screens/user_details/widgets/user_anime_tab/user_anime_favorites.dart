import 'package:anime_app/features/profile/screens/user_details/widgets/user_anime_tab/anime_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../anime/screens/details/anime_details.dart';


class UserAnimeFavorites extends StatelessWidget {
  const UserAnimeFavorites({super.key, required this.animeList});

  final List<dynamic> animeList;

  @override
  Widget build(BuildContext context) {
    if (animeList.isNotEmpty) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Favorites", style: TextStyle(
                fontSize: 16
            ),),
            SizedBox(height: 4.h,),
            SizedBox(
                height: 200.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: animeList.length,
                  itemBuilder: (_,index) {
                    final anime = animeList[index];
                    return AnimeCardWidget(anime: anime, image: anime["images"]["jpg"]["large_image_url"],);
                  },
                  separatorBuilder: (_,__)=>SizedBox(
                    width: 4.w,
                  ),
                )
            )],
      );
    } else {
      return const Center(child: Text("No data"),);
    }
  }
}
