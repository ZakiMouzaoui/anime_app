import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class KBarTheme {
  KBarTheme._();

  static AppBarTheme appBarTheme = AppBarTheme(
      titleTextStyle: const TextStyle(
        fontSize: 18,
      ),
      elevation: 0,
      backgroundColor: Colors.blueGrey[800],
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: KColors.primary
    ),
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white60
    )
  );
}
