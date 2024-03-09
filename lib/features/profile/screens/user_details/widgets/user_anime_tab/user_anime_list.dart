import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'anime_card_widget.dart';

class UserAnimeList extends StatelessWidget {
  const UserAnimeList({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final query = Query(key: url, queryFn: ()=>ApiService.instance.get(url,
        headers: {
          "X-MAL-CLIENT-ID": "389838c8fcd99e6c919c0835164c2e50"
        },
        base: "https://api.myanimelist.net/v2"));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 4.h,
        ),
        QueryBuilder(
            query: query,
            builder: (_, state){
              if(state.status == QueryStatus.loading){
                return Container(
                  height: 200.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, __) => Column(
                        children: [
                          Container(
                            height: 160.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: KColors.darkContainer,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            height: 10.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: KColors.darkContainer,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        ],
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        width: 12.w,
                      ),
                      itemCount: 5),
                );
              }
              final animeList = (state.data! as Map<String, dynamic>)["data"];
              if (animeList.isNotEmpty) {
                return SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: animeList.length,
                        itemBuilder: (_, index) {
                          final anime = animeList[index]["node"];
                          return AnimeCardWidget(anime: anime, image: anime["main_picture"]["large"],);
                        },
                        separatorBuilder: (_, __) => SizedBox(
                          width: 4.w,
                        )));
              }
              return Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 16.h), child: const Text("No data to show")));
            }
        ),

      ],
    );
  }
}