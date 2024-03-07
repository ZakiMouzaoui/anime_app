import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';

class HorizontalAnimeCard extends StatelessWidget {
  const HorizontalAnimeCard({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    final genres = anime["genres"] as List;

    return InkWell(
      onTap: ()=>Get.to(()=>AnimeDetails(animeId: anime["mal_id"], animeTitle: anime["title"],)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
                Container(
                  height: 120.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: anime["images"]["jpg"]["image_url"],
                      fit: BoxFit.cover,
                      placeholder: (_,__)=>Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: KColors.darkContainer,
                      ),
                      errorWidget: (_,__,___)=>const Icon(Icons.error_outline),
                    ),
                  ),
                ),

            SizedBox(width: 16.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(anime["title"], overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70
                    ),),
                    SizedBox(height: 2.h,),

                    Flexible(
                      child: Text(anime["status"], overflow: TextOverflow.ellipsis, style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70
                      )),
                    ),
                    SizedBox(height: 2.h,),
                    if(genres.isNotEmpty)Text.rich(
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      TextSpan(text: '', children: List.generate(genres.length, (index) => TextSpan(
                        text: "${genres[index]["name"]}${index == genres.length-1 ? "" : ","} ",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70
                        ),
                      )),
                    )),
                    SizedBox(height: 2.h,),
                    Text(anime["aired"]["prop"]["from"]["year"]?.toString() ?? "", style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70
                    ),),
                    Row(
                      children: [
                        if(anime["type"] != null)Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(anime["type"], style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70
                          )),
                        ),
                        if(anime["score"] != null)Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 13,),
                            SizedBox(width: 4.w,),
                            Text(anime["score"].toString(), style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70
                            )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    ).animate(value: 0.5).scale();
  }
}
