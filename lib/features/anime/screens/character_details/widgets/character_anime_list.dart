import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';


class CharacterAnimeList extends StatelessWidget {
  const CharacterAnimeList({super.key, required this.animeList});

  final List animeList;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Anime", style: TextStyle(
                fontSize: 16
            ),),
            SizedBox(height: 8.h,),
            if(animeList.isNotEmpty)
            SizedBox(
              height: 190.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index){
                    final anime = animeList[index]["anime"];
                    return SizedBox(
                      width: 120.w,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  height: 160.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: KColors.darkContainer,
                                      image: DecorationImage(
                                          image:
                                          CachedNetworkImageProvider(
                                              anime["images"]["jpg"]
                                              ["image_url"]),
                                          fit: BoxFit.cover)),
                                  width: 120.w),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: ()=>Get.to(()=>AnimeDetails(animeTitle: anime["title"], animeId: anime["mal_id"])),
                                  child: SizedBox(
                                    height: 160.h,
                                    width: 120.w,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Flexible(
                              child: Text(
                                anime["title"],
                                style: const TextStyle(
                                    color: Colors.white70),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(
                    width: 8.w,
                  ),
                  itemCount: animeList.length),
            )
            else const Center(child: Text("No data"),)
          ],
        ));
  }
}
