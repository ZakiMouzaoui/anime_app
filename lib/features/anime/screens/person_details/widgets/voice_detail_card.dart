import 'package:anime_app/features/anime/screens/character_details/character_details.dart';
import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';

class VoiceDetailCard extends StatelessWidget {
  const VoiceDetailCard({super.key, required this.voice});

  final Map<String, dynamic> voice;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 110.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KColors.darkContainer,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          voice["character"]["images"]["jpg"]["image_url"]),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 110.w,
                height: 150.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.05)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.h, 5.h]),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    voice["character"]["name"],
                    style:
                        const TextStyle(height: 1, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => {
                    Get.to(
                      () => CharacterDetails(
                          characterId: voice["character"]["mal_id"],
                          title: voice["character"]["name"]),
                      preventDuplicates: false,
                      arguments: {
                        "characterId": voice["character"]["mal_id"]
                      }
                    )
                  },
                  child: SizedBox(
                    height: 150.h,
                    width: 110.w,
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              const Icon(
                Icons.arrow_forward_rounded,
                size: 32,
                color: Colors.white70,
              ),
              Text(
                "${voice["role"]} character",
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                width: 110.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KColors.darkContainer,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          voice["anime"]["images"]["jpg"]["large_image_url"]),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 110.w,
                height: 150.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.05)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.h, 5.h]),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    voice["anime"]["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(height: 1, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => Get.to(() => AnimeDetails(
                      animeTitle: voice['anime']['title'],
                      animeId: voice['anime']['mal_id'])),
                  child: SizedBox(
                    height: 150.h,
                    width: 110.w,
                  ),
                ),
              )
            ],
          ),
        ],
      ).animate(value: 0.8).scale();
  }
}
