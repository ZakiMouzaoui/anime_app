import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/anime/screens/details/anime_details.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RelatedAnime extends StatelessWidget {
  const RelatedAnime(
      {super.key,
      required this.animeId,
      required this.cover,
      required this.relations});

  final int animeId;
  final String cover;
  final List relations;

  @override
  Widget build(BuildContext context) {
    final Map<String, List> animeList = {};

    print("rebuilding");

    for (var element in relations) {
      final relation = element["relation"];
      animeList[relation] = element["entry"];
    }

    return animeList.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Related",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                    height: 190.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: animeList.entries.map((e) {
                          final animeList = e.value
                              .where((element) => element["type"] == "anime")
                              .toList();
                          return Row(
                            children: animeList
                                .map((anime) => Container(
                                      margin: EdgeInsets.only(right: 16.w),
                                      width: 120.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 160.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                width: double.infinity,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: FutureBuilder(
                                                          future: ApiService
                                                              .instance
                                                              .get(
                                                                  'anime/${anime["mal_id"]}/pictures'),
                                                          builder:
                                                              (_, snapshot) {
                                                            if (snapshot
                                                                    .hasError ||
                                                                !snapshot
                                                                    .hasData) {
                                                              return Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                color: KColors
                                                                    .darkContainer,
                                                              );
                                                            }
                                                            final url = snapshot
                                                                            .data![
                                                                        "data"]
                                                                    [0]["jpg"]
                                                                ["image_url"];
                                                            return CachedNetworkImage(
                                                              imageUrl: url,
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  (_, __) =>
                                                                      Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                color: KColors
                                                                    .darkContainer,
                                                              ),
                                                            );
                                                          },
                                                        )),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4.w,
                                                                vertical: 4.h),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: FittedBox(
                                                          child: Text(
                                                            e.key,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  onTap: () {
                                                    Get.to(
                                                        () => AnimeDetails(
                                                            animeTitle:
                                                                anime["name"],
                                                            animeId: anime[
                                                                "mal_id"]),
                                                        preventDuplicates:
                                                            false);
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
                                            anime["name"],
                                            style: const TextStyle(
                                                color: Colors.white70),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          );
                        }).toList(),
                      ),
                    ))
              ],
            ),
          )
        : const SizedBox();
  }
}
