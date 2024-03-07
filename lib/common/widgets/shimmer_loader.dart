import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants/colors.dart';


class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key, required this.height, required this.width, this.radius=5});

  final double height, width, radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: KColors.darkContainer,
        highlightColor: KColors.darkContainer.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: KColors.darkerGrey,
          ),
          height: height,
          width: width,
        )
    );
  }
}
