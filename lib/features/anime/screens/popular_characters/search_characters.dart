import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/features/anime/screens/popular_characters/widgets/popular_character_card.dart';
import 'package:anime_app/features/controllers/characters/search_characters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';


class SearchCharacters extends StatelessWidget {
  const SearchCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchCharactersController());

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: "Enter character name...",
          ),
          onChanged: (_)=>controller.onQueryChange(),
          controller: controller.searchController,
          cursorColor: Colors.blue,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (_)=>controller.searchCharacters(),
        ),
        actions: [
          Obx(() => controller.showClearBtn.isTrue ? IconButton(onPressed: (){
            controller.searchController.clear();
            controller.showClearBtn.value = false;
          }, icon: const Icon(Icons.clear),) : const SizedBox())
        ],
      ),
      body: Obx((){
        if(controller.isLoading.isTrue){
          return const Center(
            child: KCircularProgressIndicator(),
          );
        }
        if(controller.characters.isEmpty){
          return const Center(
            child: Text("No data found"),
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
                  return AnimationConfiguration.synchronized(
                      key: Key('${character["mal_id"]}'),
                      duration: const Duration(milliseconds: 375),
                      child: ScaleAnimation(
                          scale: 0.9,
                          child: PopularCharacterCard(character: character)));
                }),
          ),
        );
      }),
    );
  }
}
