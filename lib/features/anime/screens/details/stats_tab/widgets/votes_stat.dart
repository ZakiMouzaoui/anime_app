import 'package:anime_app/features/anime/screens/details/stats_tab/widgets/stat_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/constants/colors.dart';


class VotesStat extends StatelessWidget {
  const VotesStat({super.key, required this.scores});

  final List<dynamic> scores;

  @override
  Widget build(BuildContext context) {
    int totalVotes =  scores.map((score) => score["votes"] ?? 0).reduce((a, b) => a + b);

    return Container(
      decoration: BoxDecoration(
        color: KColors.darkContainer,
        borderRadius: BorderRadius.circular(2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Votes"),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(10, (index) => StatBar(score: scores[9-index]["votes"].toString(), percentage: scores[9-index]["votes"]/totalVotes, margin: index==9 ? 0:null,)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const Divider(height: 0, color: KColors.darkGrey,),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(10, (index) => Container(
                margin: EdgeInsets.only(right: 8.w),
                width: 25.w,
                child: Text("${10-index}", textAlign: TextAlign.center, style: const TextStyle(
                    fontSize: 12
                ),),
              )),
            ),
          )
        ],
      ),
    );
  }
}
