import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/character_details/widgets/character_anime_list.dart';
import 'package:anime_app/features/anime/screens/character_details/widgets/character_voice_actor_row.dart';
import 'package:anime_app/features/controllers/characters/character_details_controller.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails(
      {super.key, required this.characterId, required this.title});

  final int characterId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CharacterDetailsController(characterId), tag: '$characterId');

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.white54,
              ))
        ],
      ),
      body: Obx((){
        if(controller.isLoading.isTrue){
          return const Center(
            child: KCircularProgressIndicator(),
          );
        }
        final voiceActors = controller.character["voices"] as List;
        final len = voiceActors.length;
        final animeList = controller.character["anime"] as List;

        return ListView(shrinkWrap: true, children: [
          /// Meta data
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Container(
                  height: 180.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              controller.character["images"]["jpg"]["image_url"]),
                          fit: BoxFit.cover),
                      color: KColors.darkContainer),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${controller.character["favorites"]}"),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.blue,
                      size: 18,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Text(
                      "liked this character",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                ReadMoreText(
                  controller.character["about"] ?? "No bio for this character",
                  moreStyle: const TextStyle(color: Colors.blue),
                  lessStyle: const TextStyle(color: Colors.blue),
                  trimMode: TrimMode.Line,
                  trimLines: 6,
                )
              ],
            ),
          ),
          Divider(
            color: KColors.darkContainer,
            height: 24.h,
          ),

          /// Voice actors
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Text(
                    "Voice Actors",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return CharacterVoiceActorRow(
                          voiceActor: voiceActors[index],
                          marginLeft: index==0 ? 16.w : 0,
                          marginRight: index == len-1 ? 16.w : 0,
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        width: 8.w,
                      ),
                      itemCount: voiceActors.length),
                )
              ],
            ),

          /// Anime
          CharacterAnimeList(animeList: animeList)
        ]);
      })
    );
  }
}