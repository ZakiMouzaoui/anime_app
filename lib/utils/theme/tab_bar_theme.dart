import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class KTabBarTheme{
  KTabBarTheme._();

  static TabBarTheme theme = TabBarTheme(
    dividerColor: Colors.transparent,
    indicatorColor: KColors.white,
    unselectedLabelColor: Colors.white54,
    labelColor: Colors.white,
    labelPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    tabAlignment: TabAlignment.start,
  );
}