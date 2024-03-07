import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/anime/screens/seasons/widgets/seasons_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OtherSeasonsTab extends StatelessWidget {
  const OtherSeasonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ApiService.instance.get("seasons"), builder: (_,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: KCircularProgressIndicator(),
        );
      }
      final data = snapshot.data!["data"] as List;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView.separated(
            itemBuilder: (_,index)=>SeasonsOptions(year: data[index]["year"], seasons: data[index]["seasons"]),
            separatorBuilder: (_,__)=>SizedBox(height: 16.h,),
            itemCount: data.length
        ),
      );
    });
  }
}
