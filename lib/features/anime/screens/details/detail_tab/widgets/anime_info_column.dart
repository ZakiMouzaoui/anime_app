import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/constants/colors.dart';

class AnimeInfoColumn extends StatelessWidget {
  const AnimeInfoColumn({super.key, required this.title, required this.info, this.infoWidget=false});

  final String title;
  final String info;
  final bool infoWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        if (infoWidget) Container(
          constraints: BoxConstraints(
            maxWidth: 150.w
          ),
          margin: EdgeInsets.only(top: 2.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: KColors.darkContainer
          ),
          child: Text(info, style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                overflow: TextOverflow.clip
              ), maxLines: 2),
        ) else Text(info, style: const TextStyle(
          color: Colors.white60,
          fontSize: 13,
          overflow: TextOverflow.ellipsis,
        ), maxLines: 2,)
      ],
    );
  }
}
