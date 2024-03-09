import 'package:anime_app/utils/constants/colors.dart';
import 'package:anime_app/utils/theme/app_bar_theme.dart';
import 'package:anime_app/utils/theme/dialog_theme.dart';
import 'package:anime_app/utils/theme/drawer_theme.dart';
import 'package:anime_app/utils/theme/tab_bar_theme.dart';
import 'package:anime_app/utils/theme/text_button_theme.dart';
import 'package:anime_app/utils/theme/text_form_field_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        backgroundColor: KColors.primary,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false
        )
      }
    ),
    appBarTheme: KBarTheme.appBarTheme,
    drawerTheme: KDrawerTheme.drawerThemeData,
    tabBarTheme: KTabBarTheme.theme,
    inputDecorationTheme: KTextFormFieldTheme.inputDecoration,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue
    ),
    dialogTheme: KDialogTheme.dialogTheme,
    textButtonTheme: KTextButtonTheme.textButtonThemeData,
    unselectedWidgetColor: Colors.white70,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
