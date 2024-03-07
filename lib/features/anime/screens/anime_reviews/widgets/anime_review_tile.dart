import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import 'package:timeago/timeago.dart' as timeago;

class AnimeReviewTile extends StatelessWidget {
  const AnimeReviewTile({super.key, required this.review});

  final Map<String, dynamic> review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
              review["user"]["images"]["jpg"]["image_url"]),
          backgroundColor: KColors.darkContainer,
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review["user"]["username"],
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    timeago.format(DateTime.parse(review["date"])),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              ReadMoreText(
                review["review"],
                trimMode: TrimMode.Line,
                trimLines: 4,
                moreStyle: const TextStyle(color: Colors.white54),
                lessStyle: const TextStyle(color: Colors.white54),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        color: Colors.white54,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(review["reactions"]["nice"].toString())
                    ],
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_down,
                        color: Colors.white54,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(review["reactions"]["confusing"].toString())
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton(

                      color: KColors.primary,
                      iconColor: Colors.white54,
                      itemBuilder: (_)=>[
                    const PopupMenuItem(child: Text("Block")),
                    const PopupMenuItem(child: Text("Report"))
                  ]),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
