import 'package:anime_app/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: 1.sh,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              InteractiveViewer(
                minScale: 0.1,
                maxScale: 4,
                scaleEnabled: true,
                panEnabled: true,
                child: Center(
                  child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      fit: BoxFit.cover,
                      width: 1.sw,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w).copyWith(top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 6.h),
                          ),
                          constraints: const BoxConstraints(),
                          onPressed: Get.back,
                          icon: const Icon(Icons.arrow_back_rounded)),
                      PopupMenuButton(
                        constraints: BoxConstraints(
                          minWidth: 180.w
                        ),
                          tooltip: "Save Image",
                          color: Colors.grey[850],
                          elevation: 0,
                          itemBuilder: (_) => [
                          PopupMenuItem(
                            onTap: (){
                              KHelperFunctions.saveImage(imgUrl);
                            },
                            child: const Text("Save image", textAlign: TextAlign.center,)
                        ),
                      ])
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
