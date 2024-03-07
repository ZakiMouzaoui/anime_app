import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/details/stats_tab/widgets/pie_chart.dart';
import 'package:anime_app/features/anime/screens/details/stats_tab/widgets/votes_stat.dart';
import 'package:anime_app/features/controllers/stats/anime_stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({super.key, required this.animeId});

  final String animeId;

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = Get.put(AnimeStatsController());

    return FutureBuilder(future: controller.getStats(widget.animeId), builder: (_,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: KCircularProgressIndicator(),
        );
      }
      if(snapshot.hasError){
        return const Center(
          child: Text("Something went wrong"),
        );
      }
      final data = snapshot.data!["data"];
      final scores = data["scores"];
      final Map<String, double> dataMap = {
        "Watching": data["watching"].toDouble(),
        "Completed": data["completed"].toDouble(),
        "On hold": data["on_hold"].toDouble(),
        "Dropped": data["dropped"].toDouble(),
        "Plan to watch": data["plan_to_watch"].toDouble(),
      };

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          children: [
            /// Votes
            if(scores.isNotEmpty) Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: VotesStat(scores: scores),
            ),

            /// Pie chart
            PieChartStat(dataMap: dataMap)
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}