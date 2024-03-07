import 'package:anime_app/features/anime/screens/details/detail_tab/widgets/trailer_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';


class AnimeTrailerThumbnail extends StatelessWidget {
  const AnimeTrailerThumbnail({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Trailer",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () => Get.to(() => TrailerPlayer(
                videoId: anime["trailer"]["youtube_id"])),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: anime["trailer"]["images"]
                      ?["small_image_url"],
                      errorWidget: (_, __, ___) => Container(
                        color: KColors.darkContainer,
                        height: double.infinity,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: KColors.dark.withOpacity(0.65)),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 28,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
