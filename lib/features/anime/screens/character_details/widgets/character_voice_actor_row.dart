import 'package:anime_app/features/anime/screens/person_details/person_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';

class CharacterVoiceActorRow extends StatelessWidget {
  const CharacterVoiceActorRow(
      {super.key,
      required this.voiceActor,
      required this.marginLeft,
      required this.marginRight});

  final Map<String, dynamic> voiceActor;
  final double marginLeft, marginRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, right: marginRight),
      constraints: BoxConstraints(
        maxWidth: 282.w,
      ),
      child: InkWell(
        onTap: () => Get.to(() => PersonDetails(
              personId: voiceActor["person"]["mal_id"],
              personName: voiceActor["person"]["name"],
              voiceLanguage: voiceActor["language"],
            )),
        borderRadius: BorderRadius.circular(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 85.w,
              height: 100.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                child: CachedNetworkImage(
                  imageUrl: voiceActor["person"]["images"]["jpg"]["image_url"],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: KColors.darkContainer,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: KColors.darkContainer,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
                height: 100.h,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 165.w,
                            child: Text(
                              voiceActor["person"]["name"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Text(
                          voiceActor["language"],
                          style: const TextStyle(color: Colors.white60),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
