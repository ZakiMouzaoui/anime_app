import 'package:anime_app/common/widgets/drawer_widget.dart';
import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/popular_characters/search_characters.dart';
import 'package:anime_app/features/anime/screens/popular_characters/widgets/popular_character_card.dart';
import 'package:anime_app/features/controllers/characters/popular_characters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class PopularCharacters extends StatelessWidget {
  const PopularCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularCharactersController());

    return RefreshIndicator(
      onRefresh: ()async{
        controller.refreshList();
      },
      color: Colors.white54,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Popular Characters"),
          actions: [IconButton(onPressed: ()=>Get.to(()=>const SearchCharacters()), icon: const Icon(Icons.search))],
        ),
        drawer: const DrawerWidget(),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: AnimationLimiter(
              child: GridView.builder(
                  itemCount: controller.characters.length,
                  controller: controller.scrollController,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.w,
                      mainAxisSpacing: 4.h,
                      mainAxisExtent: 150.h),
                  itemBuilder: (_, index) {
                    final character = controller.characters[index];
                    return PopularCharacterCard(character: character).animate(value: 0.7).scale();
                  }),
            ),
          );
        }),
      ),
    );
  }
}
