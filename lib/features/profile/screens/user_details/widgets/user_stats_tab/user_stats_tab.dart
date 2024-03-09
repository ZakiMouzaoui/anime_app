import 'package:anime_app/features/anime/screens/details/stats_tab/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class UserStatsTab extends StatelessWidget {
  const UserStatsTab({super.key, required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      "Days Watched": stats["days_watched"].toDouble(),
      "Watching": stats["watching"].toDouble(),
      "Completed": stats["completed"].toDouble(),
      "On hold": stats["on_hold"].toDouble(),
      "Dropped": stats["dropped"].toDouble(),
      "Plan to watch": stats["plan_to_watch"].toDouble(),
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChartStat(dataMap: dataMap),
          SizedBox(height: 16.h,),
          Text("Episodes watched: ${stats["episodes_watched"]}", style: const TextStyle(
            fontSize: 13,
            color: Colors.white70
          ),),
        ],
      ),
    );
  }
}
