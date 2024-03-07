import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/anime/screens/person_details/widgets/actor_voices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/colors.dart';


class PersonDetails extends StatelessWidget {
  const PersonDetails({super.key, required this.personId, required this.personName, required this.voiceLanguage});

  final int personId;
  final String personName;
  final String voiceLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personName, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: FutureBuilder(
        future: ApiService.instance.get("people/$personId/full"),
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          final person = snapshot.data!["data"];
          final voices = person["voices"] as List;


          return CustomScrollView(
            slivers: [
              SliverList.list(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    children: [
                      Container(
                        height: 180.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    person["images"]["jpg"]["image_url"]),
                                fit: BoxFit.cover),
                            color: KColors.darkContainer),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        personName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      Text(voiceLanguage, style: const TextStyle(
                          color: Colors.white70
                      ),),

                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white24,
                  height: 0,
                ),
              ]),
              ActorVoices(voices: voices),
            ]
          );
        },
      )
    );
  }
}
