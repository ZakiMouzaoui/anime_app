import 'dart:math';

import 'package:anime_app/features/anime/screens/character_details/character_details.dart';
import 'package:anime_app/features/anime/screens/details/characters_tab/all_characters.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';

class CharactersHorizontalList extends StatelessWidget {
  const CharactersHorizontalList(
      {super.key,
      required this.title,
      required this.characters,
        this.isStaff=false
      });

  final String title;
  final List characters;
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    final hasMore = characters.length > 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            if (hasMore)
              SizedBox(
                height: 30.h,
                child: IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //alignment: Alignment.bottomCenter
                    ),
                    onPressed: () async {
                      await Get.to(() => AllCharacters(
                            title: title,
                            characters: characters,
                        isStaff: isStaff,
                          ));
                    },
                    icon: const Text(
                      "View All",
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                    )),
              )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        if(characters.isNotEmpty) SizedBox(
          height: 140.h,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final character = isStaff ? characters[index]["person"] : characters[index]["character"];
                return Container(
                      height: 140.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: character["images"]["jpg"]["image_url"],
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: KColors.darkContainer,
                              ),
                              errorWidget: (_, __, ___) =>
                                  const Icon(Icons.error_outline),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      KColors.black.withOpacity(0.7),
                                      KColors.black.withOpacity(0.05)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                                borderRadius: BorderRadius.circular(5)),
                            height: double.infinity,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
                            child: Text(character["name"], maxLines: 2,),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            color:  Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: (){
                                if(!isStaff){
                                  Get.to(
                                      (()=>CharacterDetails(title: character["name"], characterId: character["mal_id"],)),
                                  );
                                }
                              },
                              child: const SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          )
                        ],
                      ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(
                    width: 8.w,
                  ),
              itemCount: min(characters.length, 10)),
        ) else const Center(
          child: Text("No data yet"),
        )
      ],
    );
  }
}
