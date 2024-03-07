import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';


class AnimeRecommendationEntry extends StatelessWidget {
  const AnimeRecommendationEntry ({super.key, required this.title, required this.anime});

  final String title;
  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white70, fontSize: 13),
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      anime["images"]["webp"]
                      ["large_image_url"]),
                  fit: BoxFit.cover),
              color: KColors.darkContainer),
          width: 100.w,
          height: 130.h,
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          width: 100.w,
          child: Text(
            anime["title"],
            style: TextStyle(
                color: Colors.blue.shade600,
                overflow: TextOverflow.ellipsis),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
