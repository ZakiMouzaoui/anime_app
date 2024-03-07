import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatBar extends StatelessWidget {
  const StatBar(
      {super.key, required this.score, required this.percentage, this.margin});

  final String score;
  final double percentage;
  final double? margin;

  @override
  Widget build(BuildContext context) {

    return Tooltip(
      message: score,
      child: Container(
        padding: EdgeInsets.only(right: margin ?? 8.w),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            /*
            SizedBox(
              width: scoreLength <= 2 ? 15.w : scoreLength == 3 ? 22.w : 28.w,
              child: FittedBox(
                child: Text(
                  score,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
             */
            Container(
              width: 25.w,
              height: percentage*0.6.sh,
              color: Colors.blue.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
