import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class KCircularProgressIndicator extends StatelessWidget {
  const KCircularProgressIndicator({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 30.w,
      height: size ?? 30.h,
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}
