import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';


class UserAnimeTab extends StatelessWidget {
  const UserAnimeTab({super.key, required this.animeList});

  final List<dynamic> animeList;

  @override
  Widget build(BuildContext context) {
    if (animeList.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Column(
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
                return InkWell(
                  onTap: ()=>Get.to(()=>AnimeDetails(animeTitle: anime["title"], animeId: anime["mal_id"])),
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 160.h,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: KColors.darkContainer,
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              anime["images"]["jpg"]["large_image_url"]
                                          ),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  width: 120.w
                                ),
                                Container(
                                  height: 160.h,
                                  width: 120.w,
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.4),
                                            Colors.black.withOpacity(0.05)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: [0.h, 5.h]
                                      )
                                  ),
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        anime["start_year"]?.toString() ?? "",
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Flexible(
                                child: SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    anime["title"],
                                    style: const TextStyle(color: Colors.white70),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ]
                      )
                  ),
                );
              },
              separatorBuilder: (_,__)=>SizedBox(
                width: 4.w,
              ),
            )
          )],
            ),
      );
    } else {
      return const Center(child: Text("No data"),);
    }
  }
}
