import 'package:flutter/material.dart';

class KTextButtonTheme{
  KTextButtonTheme._();

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)))
  );
}