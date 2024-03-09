import 'package:anime_app/features/profile/screens/user_details/widgets/user_anime_tab/user_anime_favorites.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_anime_tab/user_anime_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserAnimeTab extends StatelessWidget {
  const UserAnimeTab({super.key, required this.animeList, required this.username});

  final List<dynamic> animeList;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      child: ListView(
        children: [
          UserAnimeFavorites(animeList: animeList),
          SizedBox(height: 16.h,),
          UserAnimeList(title: "Watching", url: "users/$username/animelist?fields=list_status&status=watching"),
          SizedBox(height: 8.h,),
          UserAnimeList(title: "Plan to Watch", url: "users/$username/animelist?fields=list_status&status=plan_to_watch"),
          SizedBox(height: 8.h,),
          UserAnimeList(title: "On Hold", url: "users/$username/animelist?fields=list_status&status=on_hold"),
          SizedBox(height: 8.h,),
          UserAnimeList(title: "Completed", url: "users/$username/animelist?fields=list_status&status=completed")
        ],
      ),
    );
  }
}
