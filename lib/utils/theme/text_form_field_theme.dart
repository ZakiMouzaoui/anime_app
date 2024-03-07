import 'package:flutter/material.dart';

class KTextFormFieldTheme{
  KTextFormFieldTheme._();

  static InputDecorationTheme inputDecoration = const InputDecorationTheme(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
        fontSize: 16
      )
  );
}