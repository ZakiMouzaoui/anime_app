import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../anime/screens/popular_characters/widgets/popular_character_card.dart';


class UserCharactersTab extends StatelessWidget {
  const UserCharactersTab({super.key, required this.characters});

  final List characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: GridView.builder(
          itemCount: characters.length,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.w,
              mainAxisSpacing: 4.h,
              mainAxisExtent: 150.h),
          itemBuilder: (_, index) {
            final character = characters[index];
            return PopularCharacterCard(character: character, showFavorites: false,).animate(value: 0.7).scale();
          }),
    );
  }
}
