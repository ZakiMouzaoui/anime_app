import 'package:anime_app/features/anime/screens/character_details/character_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';


class PopularCharacterCard extends StatelessWidget {
  const PopularCharacterCard({super.key, required this.character, this.showFavorites=true});

  final Map<String, dynamic> character;
  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key("${character["mal_id"]}"),
      onTap: ()=>Get.to(()=>CharacterDetails(characterId: character["mal_id"], title: character["name"]), arguments: {
        "characterId": character["mal_id"]
      }),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: 150.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: character["images"]["jpg"]["image_url"],
                  fit: BoxFit.cover,
                  placeholder: (_,__)=>Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: KColors.darkContainer,
                  ),
                  errorWidget: (_,__,___)=>const Icon(Icons.error_outline),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: showFavorites ? LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ) : LinearGradient(colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ], begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(showFavorites)Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${character["favorites"]}', style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                      ),),
                      SizedBox(width: 2.w,),
                      const Icon(Icons.favorite,size: 18,)
                    ],
                  ),
                  const Spacer(),
                  Text(character["name"], maxLines: 2, style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    height: 1
                  ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
