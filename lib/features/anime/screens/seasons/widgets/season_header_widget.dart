import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SeasonHeaderWidget extends StatelessWidget {
  const SeasonHeaderWidget({super.key, required this.season, required this.year});

  final String season;
  final String year;

  @override
  Widget build(BuildContext context) {
    String gifPath = season == "Winter" ? "winter-gif.gif" : season == "Spring" ? "spring.gif" : season == "Summer" ? "summer.gif" : "autumn.gif";
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(TextSpan(
                text: "$season ",
                style: const TextStyle(
                    fontSize: 16
                ),
                children: [
                  TextSpan(
                      text: year,
                      style: const TextStyle(
                          fontSize: 18
                      )
                  )
                ]
            )),
            SizedBox(width: 8.w,),
            Image.asset("assets/images/$gifPath", width: 30.w, height: 30.h,)
          ],
        )
    );
  }
}
