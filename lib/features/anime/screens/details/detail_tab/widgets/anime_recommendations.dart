import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:anime_app/features/controllers/anime/anime_details_controller.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/recommendations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnimeRecommendations extends StatelessWidget {
  const AnimeRecommendations({super.key, required this.animeId});

  final String animeId;

  @override
  Widget build(BuildContext context) {
    final detailCtr = Get.put(AnimeDetailsController());

    return FutureBuilder(
        future: detailCtr.getAnimeRecommendations(animeId.toString()),
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recommendations",
                        style: TextStyle(fontSize: 16),
                      ),
                      if(snapshot.data!.length > 5)TextButton(onPressed: ()=>Get.to(()=>const Recommendations()), child: const Text("View all", style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue
                      ),))
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final anime = snapshot.data![index]["entry"];

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
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  anime["images"]["jpg"]
                                                      ["image_url"]),
                                              fit: BoxFit.cover)),
                                      width: double.infinity,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          Get.to(() => AnimeDetails(
                                              animeTitle: anime["title"],
                                              animeId: anime["mal_id"]),
                                            preventDuplicates: false
                                          );
                                        },
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
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            ),
                          ).animate(value: 0.5).scale();
                        },
                        separatorBuilder: (_, __) => SizedBox(
                              width: 16.w,
                            ),
                        itemCount: snapshot.data!.length),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
