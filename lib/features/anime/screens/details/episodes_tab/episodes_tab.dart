import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodesTab extends StatefulWidget {
  const EpisodesTab({super.key, required this.animeId});

  @override
  State<EpisodesTab> createState() => _EpisodesTabState();

  final int animeId;
}

class _EpisodesTabState extends State<EpisodesTab> {


  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(AnimeEpisodesController());
    return FutureBuilder(
        future: ApiService.instance.get("anime/${widget.animeId}/episodes"),
        builder: (_, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          final episodes = snapshot.data!["data"] as List;
          final len = episodes.length;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: ListView.separated(
                itemBuilder: (_,index)=>InkWell(
                  onTap: (){},
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.only(left: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Episode: ${len-episodes[index]["mal_id"]+1}'
                        ),
                        Row(
                          children: [
                            if(episodes[index]["filler"])Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              color: Colors.red.shade800,
                              height: 25.h,
                              child: const FittedBox(
                                child: Text("Filler"),
                              ),
                            ),
                            IconButton(padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h), onPressed: (){}, icon: const Icon(Icons.remove_red_eye_rounded, size: 18, color: Colors.white70,)),
                            IconButton(padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h), onPressed: (){}, icon: const Icon(Icons.message_rounded, size: 18, color: Colors.white70,))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (_,__)=>SizedBox(height: 6.h,),
                itemCount: len
            ),
          );
        }
    );
  }
}
