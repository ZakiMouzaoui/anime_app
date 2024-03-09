import 'package:anime_app/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';


class AnimeMetaData extends StatelessWidget {
  const AnimeMetaData({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onLongPress: (){
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
              builder: (_)=>Material(
                color: KColors.primary,
                child: InkWell(
                  onTap: (){
                    Get.back();
                    KHelperFunctions.saveImage(anime["images"]["jpg"]["large_image_url"]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Save"),
                        Icon(Icons.download_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
              height: 160.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KColors.darkContainer,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          anime["images"]["jpg"]["large_image_url"]),
                      fit: BoxFit.cover)),
              width: 120.w),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime["title"],
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                anime["status"],
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  if (anime["season"] != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        anime["season"].toString().capitalize!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  Text(
                    anime["aired"]["prop"]["from"]["year"]
                        ?.toString() ??
                        "",
                    style:
                    const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Text.rich(
                TextSpan(children: [
                  if (anime["type"] != null)
                    TextSpan(
                      text: "${anime["type"]} | ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300),
                    ),
                  if (anime["status"] != "Not yet aired")
                    TextSpan(
                      text: "${anime["episodes"]} | ".toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300),
                    ),
                  if (anime["rating"] != null)
                    TextSpan(
                      text: anime["rating"].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.ellipsis),
                    ),
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
