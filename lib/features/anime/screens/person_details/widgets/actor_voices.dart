import 'package:anime_app/features/anime/screens/person_details/widgets/voice_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ActorVoices extends StatelessWidget {
  const ActorVoices({super.key, required this.voices});

  final List voices;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      sliver: SliverList.separated(
              itemBuilder: (_,index)=>VoiceDetailCard(voice: voices[index]),
              separatorBuilder: (_,__)=>SizedBox(height: 16.h,),
              itemCount: voices.length
      ),
    );
  }
}
