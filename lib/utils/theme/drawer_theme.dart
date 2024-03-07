import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class KDrawerTheme{
  KDrawerTheme._();

  static DrawerThemeData drawerThemeData = DrawerThemeData(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    width: 0.6.sw,
    backgroundColor: KColors.primary
  );
}