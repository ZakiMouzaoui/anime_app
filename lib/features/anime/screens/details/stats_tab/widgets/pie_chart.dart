import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../../../utils/constants/colors.dart';


class PieChartStat extends StatelessWidget {
  const PieChartStat({super.key, required this.dataMap});

  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    final entries = dataMap.entries.toList();

    return Container(
      decoration: BoxDecoration(
        color: KColors.darkContainer,
        borderRadius: BorderRadius.circular(2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        chartValuesOptions: const ChartValuesOptions(
          showChartValues: false,

        ),
        legendLabels:  Map.fromEntries(
          entries.map(
                (entry) => MapEntry(
              entry.key,
              "${entry.key}: ${entry.value.floor()}",
            ),
          ),
        ),
      ),
    );
  }
}
