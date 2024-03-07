import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';

class AllCharacters extends StatelessWidget {
  const AllCharacters(
      {super.key, required this.title, required this.characters, this.isStaff=false});

  final String title;
  final List characters;
  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.w,
              mainAxisSpacing: 4.h,
              mainAxisExtent: 150.h),
          itemCount: characters.length,
          itemBuilder: (_, index) {
            final character = !isStaff ? characters[index]["character"] : characters[index]["person"];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Stack(
                  children: [
                    Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: KColors.darkContainer,
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: character["images"]["jpg"]
                              ["image_url"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [
                                KColors.dark.withOpacity(0.7),
                                KColors.dark.withOpacity(0.05),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: Padding(
                            padding: EdgeInsets.only(left: 8.w,right: 2.w, bottom: 4.h),
                            child: Text(character["name"])))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
