import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class KBarTheme {
  KBarTheme._();

  static AppBarTheme appBarTheme = const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
      ),
      backgroundColor: Color(0xff30324d),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: KColors.primary
    ),
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white60
    )
  );
}
