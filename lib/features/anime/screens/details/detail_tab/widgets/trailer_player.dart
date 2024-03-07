import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class TrailerPlayer extends StatelessWidget {
  const TrailerPlayer({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
        useHybridComposition: false,
      ),
    );

    return PopScope(
      onPopInvoked: (_)async{
        if(controller.value.isFullScreen){
          controller.toggleFullScreenMode();
        }
      },

      child: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            },
            child: YoutubePlayer(controller: controller,progressColors: const ProgressBarColors(
              handleColor: Colors.red,
              playedColor: Colors.red,
              bufferedColor: Colors.white70,
              backgroundColor: Colors.grey
            ),
              showVideoProgressIndicator: false,
            ),
          ),
        ),
      ),
    );
  }
}
