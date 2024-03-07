import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../controllers/search/anime_search_controller.dart';
import '../../../anime_search/anime_search.dart';
import 'anime_info_column.dart';


class AnimeSynopsis extends StatelessWidget {
  const AnimeSynopsis({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: KColors.darkContainer,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (anime["synopsis"] != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: ReadMoreText(
                anime["synopsis"],
                style: const TextStyle(color: Colors.white60),
                trimMode: TrimMode.Line,
                trimLines: 5,
                moreStyle: const TextStyle(color: KColors.info),
                lessStyle: const TextStyle(color: KColors.info),
              ),
            ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8.w,
            runSpacing: 8.h,
            alignment: WrapAlignment.start,
            children: List.generate(anime["genres"].length, (index) {
              final genre = anime["genres"][index]["name"];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    final ctr = Get.put(
                        AnimeSearchController(fetchFirstTime: false));
                    final id =
                    anime["genres"][index]['mal_id'].toString();
                    ctr.selectedGenreOptions.clear();
                    ctr.selectedGenreOptions.add(id);
                    ctr.genreQuery = "genres=$id";
                    ctr.filterAnime(hasBack: false);
                    Get.to(() =>
                    const AnimeSearch(fetchFirstTime: false));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: KColors.darkContainer),
                    child: Text(
                      genre,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.white60),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimeInfoColumn(
                      title: "Source", info: anime["source"]),
                  SizedBox(
                    height: 16.h,
                  ),
                  AnimeInfoColumn(
                      title: "Broadcast From",
                      info: anime["aired"]["from"]?.split("T")[0] ??
                          "?"),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (anime["studios"] != null &&
                      anime["studios"].isNotEmpty)
                    AnimeInfoColumn(
                      title: "Studio",
                      info: anime["studios"][0]["name"],
                      infoWidget: true,
                    ),
                ],
              ),
              SizedBox(
                width: 56.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimeInfoColumn(
                        title: "Episode Duration",
                        info: anime["duration"].split("per")[0]),
                    SizedBox(
                      height: 16.h,
                    ),
                    AnimeInfoColumn(
                        title: "To",
                        info: anime["aired"]["to"]?.split("T")[0] ??
                            "?"),
                    SizedBox(
                      height: 16.h,
                    ),
                    if (anime["title_english"] != null)
                      AnimeInfoColumn(
                          title: "English Title",
                          info: anime["title_english"])
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
