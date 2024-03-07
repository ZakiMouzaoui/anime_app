import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/details/characters_tab/widgets/characters_horizontal_list.dart';
import 'package:anime_app/features/controllers/characters/anime_characters_controller.dart';
import 'package:anime_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CharactersTab extends StatefulWidget {
  const CharactersTab({super.key, required this.animeId});

  final String animeId;

  @override
  State<CharactersTab> createState() => _CharactersTabState();
}

class _CharactersTabState extends State<CharactersTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = Get.put(AnimeCharactersController());

    return FutureBuilder(
        future: controller.getAnimeCharacters(widget.animeId),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData) {
            final characters = snapshot.data!["data"] as List;
            final mainCharacters = characters
                .where((element) => element["role"] == "Main")
                .toList();
            final supportingCharacters = characters
                .where((element) => element["role"] == "Supporting")
                .toList();

            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    /// Main characters
                    CharactersHorizontalList(
                        characters: mainCharacters, title: 'Main Characters'),

                    SizedBox(
                      height: 16.h,
                    ),

                    /// Supporting characters
                    CharactersHorizontalList(
                        characters: supportingCharacters,
                        title: 'Supporting Characters'),
                    SizedBox(
                      height: 16.h,
                    ),

                    /// Staffs
                    FutureBuilder(
                        future: controller.getAnimeStaffs(widget.animeId),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Staffs",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  height: 140.h,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, __) => Container(
                                            decoration: BoxDecoration(
                                                color: KColors.darkContainer,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            width: 110.w,
                                            height: 140.h,
                                          ),
                                      separatorBuilder: (_, __) => SizedBox(
                                            width: 8.w,
                                          ),
                                      itemCount: 5),
                                ),
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          final staffs = snapshot.data!["data"] as List;
                          if (staffs.isNotEmpty) {
                            return CharactersHorizontalList(
                              title: "Staffs",
                              characters: staffs,
                              isStaff: true,
                            );
                          }
                          return const Center(
                            child: Text("No data yet"),
                          );
                        })
                  ],
                ));
          }
          return const Center(
            child: KCircularProgressIndicator(),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
