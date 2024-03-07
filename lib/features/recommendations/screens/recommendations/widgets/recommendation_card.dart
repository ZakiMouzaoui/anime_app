import 'package:anime_app/features/recommendations/screens/recommendations/recommendation_detail.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/widgets/anime_recommendation_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';


class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key, required this.entry, this.showContent=true});

  final Map<String, dynamic> entry;
  final bool showContent;

  @override
  Widget build(BuildContext context) {
    final firstAnime = entry["entry"][0];
    final secondAnime = entry["entry"][1];

    return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: ()=>Get.to(()=>RecommendationDetail(entry: entry)),
        child: Container(
          decoration: BoxDecoration(
            color: KColors.darkContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          padding:
          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // first anime
                  AnimeRecommendationEntry(title: "If you've liked", anime: firstAnime),
                  Image.asset("assets/images/recommendation-icon.png", width: 50.w, height: 50.h, color: Colors.grey,),
                  AnimeRecommendationEntry(title: "You'd like", anime: secondAnime),
                ],
              ),
              if(showContent)
              Column(
                children: [
                  SizedBox(height: 8.h,),
                  Text(entry["content"], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
                      color: Colors.white70
                  ),),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry["user"]["username"], style: TextStyle(
                        color: Colors.blue.shade600,
                      ),),
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                          child: Text("More", style: TextStyle(
                              color: Colors.blue.shade600,
                              fontSize: 12
                          ),),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
    ).animate().scale(
        curve: Curves.ease);
  }
}
