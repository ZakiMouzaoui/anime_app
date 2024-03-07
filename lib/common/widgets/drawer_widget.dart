import 'package:anime_app/common/controllers/drawer_controller.dart';
import 'package:anime_app/common/widgets/drawer_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetxDrawerController());

    return SafeArea(child: Drawer(
      child: Column(
          children: [
            InkWell(onTap: (){}, child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(child: CircleAvatar(backgroundImage: AssetImage("assets/images/default-avatar.webp"), radius: 25,)),
                      Icon(Icons.notifications_none_rounded, color: Colors.white54,),
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  const Text("yuno gasai", style: TextStyle(
                    color: Colors.white60
                  ),)
                ],
              ),
            )),
            const DrawerTileWidget(index: 0, icon: FontAwesomeIcons.fireFlameCurved, title: "Latest Updates"),
            const DrawerTileWidget(index: 1, icon: Icons.list_rounded, title: "Anime List"),
            const DrawerTileWidget(index: 2, icon: Icons.date_range_rounded, title: "Seasons"),
            const Divider(color: Colors.white24,),
            const DrawerTileWidget(index: 3, icon: Icons.insert_chart, title: "Rankings"),
            const Divider(color: Colors.white24,),
            const DrawerTileWidget(index: 4, icon: Icons.favorite_rounded, title: "Favorites Anime"),
            DrawerTileWidget(onTap: (){}, index: 5, icon: Icons.favorite_rounded, title: "Favorites Characters"),
            DrawerTileWidget(onTap: (){}, index: 6, icon: Icons.access_time_rounded, title: "Watch History"),
            DrawerTileWidget(onTap: (){}, index: 7, icon: Icons.download_rounded, title: "My Downloads"),
            const Divider(color: Colors.white24,),
            const DrawerTileWidget(index: 8, icon: CupertinoIcons.chart_bar_fill, iconSize: 22, title: "Popular Characters"),
            const DrawerTileWidget(index: 9, icon: FontAwesomeIcons.puzzlePiece, iconSize: 22, title: "Recommendations"),
            const DrawerTileWidget(index: 10, icon: Icons.date_range_rounded, iconSize: 22, title: "Schedules"),
            const Divider(color: Colors.white24,),
            DrawerTileWidget(onTap: (){}, index: 11, icon: Icons.settings_rounded, title: "Settings"),
          ],
        ),
      ),
    );
  }
}
