import 'package:anime_app/common/widgets/image_preview.dart';
import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_anime_tab/user_anime_tab.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_characters_tab/user_characters_tab.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_metadata_row.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_recommendations_tab/user_recommendations.dart';
import 'package:anime_app/features/profile/screens/user_details/widgets/user_stats_tab/user_stats_tab.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.username});

  final String username;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabCtr = TabController(length: 4, vsync: this);

    final query = Query<dynamic>(key: [
      "users/${widget.username}"
    ], queryFn: () => ApiService.instance.get("users/${widget.username}/full"));

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        body: QueryBuilder(
            query: query,
            builder: (context, state) {
              if (state.status == QueryStatus.loading) {
                return const Center(
                  child: KCircularProgressIndicator(),
                );
              }
              final data = (state.data as Map<String, dynamic>)["data"];

              return NestedScrollView(
                headerSliverBuilder: (context, isInnerScrolled) => [
                  SliverOverlapAbsorber(
                    sliver: SliverSafeArea(
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: _HeaderDelegate(data, tabController: tabCtr),
                      ),
                    ),
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                ],
                body: TabBarView(
                  controller: tabCtr,
                  children: [
                    UserStatsTab(stats: data["statistics"]["anime"]),
                    UserAnimeTab(animeList: data["favorites"]['anime'], username: data["username"],),
                    UserCharactersTab(
                        characters: data["favorites"]['characters']),
                    UserRecommendationsTab(username: data["username"]),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

double _maxHeaderExtent = 340.h;

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate(this.data, {required this.tabController});

  final Map<String, dynamic> data;
  final TabController tabController;

  double baseExtent = 320.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / _maxHeaderExtent;

    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(color: KColors.primary),

          if (percent < 0.7)
            Positioned(
              top: -shrinkOffset * 0.6,
              right: 0,
              left: 0,
              child: Stack(
                children: [
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: data["images"]["jpg"]["image_url"] ??
                              'https://yourteachingmentor.com/wp-content/uploads/2020/12/istockphoto-1223671392-612x612-1.jpg',
                          height: 140.h,
                          width: size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 48.h, horizontal: 16.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["username"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              if (data['about'] != null)
                                Text(
                                  data["about"],
                                  maxLines: 2,
                                ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 4.h,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: [
                                  if (data["location"] != null)
                                    UserMetaDataRow(
                                        icon: Icons.location_on_outlined,
                                        info: data["location"]),
                                  if (data["birthday"] != null)
                                    UserMetaDataRow(
                                        icon: CupertinoIcons.calendar,
                                        info:
                                            "Birthday ${data["birthday"].split("T")[0]}"),
                                  if (data["joined"] != null)
                                    UserMetaDataRow(
                                        icon: CupertinoIcons.time,
                                        info:
                                            "Joined ${data["joined"].split("T")[0]}")
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100.h,
                    left: 16.w,
                    child: GestureDetector(
                      onTap: () => Get.to(() => ImagePreview(
                          imgUrl: data["images"]["jpg"]["image_url"] ??
                              'https://yourteachingmentor.com/wp-content/uploads/2020/12/istockphoto-1223671392-612x612-1.jpg')),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(data[
                                    "images"]["jpg"]["image_url"] ??
                                'https://yourteachingmentor.com/wp-content/uploads/2020/12/istockphoto-1223671392-612x612-1.jpg'),
                            radius: 42,
                          ),
                          Container(
                            height: 84.h,
                            width: 84.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Tab bar
          Container(
            color: KColors.primary,
            child: TabBar(
              dividerColor: KColors.darkContainer,
              controller: tabController,
              tabAlignment: TabAlignment.center,
              labelPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              isScrollable: true,
              tabs: const [
                Text("Stats"),
                Text("Anime"),
                Text("Characters"),
                Text("Recommendations")
              ],
            ),
          ),
          Positioned(
            left: 16.w,
            top: 16.h,
            child: IconButton(
              style: IconButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  backgroundColor: KColors.primary),
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Positioned(
            right: 16.w,
            top: 16.h,
            child: IconButton(
              style: IconButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  backgroundColor: KColors.primary),
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ),
          if (percent > 0.7)
            Positioned(
                top: 20.h,
                left: 84.w,
                child: Text(
                  data['username'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ))
        ],
      ),
    );
  }

  @override
  double get maxExtent =>
      baseExtent +
      (data["about"] != null ? 30.h : 0) +
      (data["joined"] != null ? 20.h : 0);

  @override
  double get minExtent => 100.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
