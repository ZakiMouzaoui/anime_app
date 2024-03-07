import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:anime_app/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerticalAnimeCard extends StatelessWidget {
  const VerticalAnimeCard({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => AnimeDetails(animeId: anime["mal_id"], animeTitle: anime["title"],)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 180.h,
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
                  width: double.infinity,
                ),
                Container(
                  height: 180.h,
                  width: double.infinity,
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
                      alignment: Alignment.bottomRight,
                      child: Text(
                        anime["aired"]["prop"]["from"]["year"]?.toString() ?? "",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime["title"],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                 Row(
                    children: [
                      if(anime["score"] != null) Row(
                        children: [
                          Text(anime["score"].toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white70)),
                          SizedBox(
                            width: 2.w,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Flexible(
                        child: Text(KHelperFunctions.getAnimeStatus(anime["status"]),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white70)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ).animate(value: 0.3).scale(curve: Curves.ease);
  }
}
