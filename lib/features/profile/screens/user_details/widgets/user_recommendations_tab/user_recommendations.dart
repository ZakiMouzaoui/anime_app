import 'package:anime_app/common/widgets/kcircular_progress_indicator.dart';
import 'package:anime_app/data/services/api_service.dart';
import 'package:anime_app/features/recommendations/screens/recommendations/widgets/recommendation_card.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRecommendationsTab extends StatefulWidget {
  const UserRecommendationsTab({super.key, required this.username});

  final String username;

  @override
  State<UserRecommendationsTab> createState() => _UserRecommendationsTabState();
}

class _UserRecommendationsTabState extends State<UserRecommendationsTab> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        _onScroll();
      }
    });
    super.initState();
  }

  void _onScroll()async{
    if(query.state.status != QueryStatus.loading){
      await query.getNextPage();
    }
  }

  late final query = InfiniteQuery(
      key: 'users/${widget.username}/recommendations',
      getNextArg: (state){
        if(state.lastPage != null){
          final pagination = (state.lastPage as Map<String, dynamic>)["pagination"];
          if(pagination["has_next_page"]){
            return state.length+1;
          }
          return null;
        }
        return 1;
      },
      queryFn: (page) => ApiService.instance.get('users/${widget.username}/recommendations?page=$page'));

  @override
  Widget build(BuildContext context) {
    return InfiniteQueryBuilder(
        query: query,
        builder: (context,state, query){
          if(state.status == QueryStatus.initial || (state.status == QueryStatus.loading && state.length == 0)){
            return const Center(
              child: KCircularProgressIndicator(),
            );
          }
          if(state.status == QueryStatus.error || state.data![0] == null || state.data!.isEmpty){
            return Center(
              child: SizedBox(
                height: 150.h,
                child: Column(
                  children: [
                    const Text("No data found"),
                    SizedBox(height: 8.h,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                        ),
                        onPressed: query.refetch, child: const Text("Try Again")
                    )
                  ],
                ),
              ),
            );
          }

          final recommendations = state.data?.expand((element) => element["data"]).toList();

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: ListView.separated(
              primary: false,
              controller: scrollController,
                itemBuilder: (_,index)=>RecommendationCard(
                    entry: recommendations[index],
                  showSplashEffect: false,
                  showFullContent: true,
                ), separatorBuilder: (_,__)=>SizedBox(
              height: 16.h,
            ), itemCount: recommendations!.length),
          );
        }
    );
  }

  @override
  void dispose() {
    scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }
}
