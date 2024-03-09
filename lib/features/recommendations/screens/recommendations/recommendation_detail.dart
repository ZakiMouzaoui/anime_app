import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/profile/screens/user_details/user_details.dart';
import 'package:anime_app/features/recommendations/controllers/recommendation_detail_controller.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/widgets/recommendation_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class RecommendationDetail extends StatelessWidget {
  const RecommendationDetail({super.key, required this.entry});

  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecommendationDetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime Recommendation"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: ListView(
          shrinkWrap: true,
          children: [
            RecommendationCard(
              entry: entry,
              showContent: false,
            ),
            SizedBox(
              height: 12.h,
            ),
            FutureBuilder(
                future: controller.getUserDetails(entry["user"]["username"]),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: KCircularProgressIndicator(
                        size: 20.w,
                      ),
                    );
                  }
                  final user = snapshot.data!["data"];
                  final favorites = user["favorites"];
                  int totalFavorites = favorites["anime"].length +
                      favorites["manga"].length +
                      favorites["characters"].length +
                      favorites["people"].length;

                  return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: KColors.darkContainer,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: ()=>Get.to(()=>UserDetails(username: user['username'])),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(user[
                                                        'images']['jpg']
                                                    ['image_url'] ??
                                                'https://yourteachingmentor.com/wp-content/uploads/2020/12/istockphoto-1223671392-612x612-1.jpg'),
                                        backgroundColor: KColors.darkContainer,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      user['username'],
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.white70,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      "$totalFavorites",
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              entry['content'],
                              style: const TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      )
                  );
                })
          ],
        ),
      ),
    );
  }
}
