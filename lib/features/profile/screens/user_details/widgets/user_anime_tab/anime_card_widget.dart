import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../anime/screens/details/anime_details.dart';



class AnimeCardWidget extends StatelessWidget {
  const AnimeCardWidget({super.key, required this.anime, required this.image});

  final Map<String, dynamic> anime;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.to(()=>AnimeDetails(animeTitle: anime["title"], animeId: anime["mal_id"] ?? anime["id"])),
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
                                    image
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
                      child: anime["start_year"] != null ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            anime["start_year"]?.toString() ?? "",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )) : const SizedBox.shrink(),
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
  }
}
