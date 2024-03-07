import 'package:anime_app/bindings/app_bindings.dart';
import 'package:anime_app/features/anime/screens/latest_anime/latest_anime.dart';
import 'package:anime_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AnimeApp extends StatelessWidget {
  const AnimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context, designSize: Size(size.width, size.height));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fade,
        initialBinding: AppBindings(),
        home: const LatestAnime(),
    );
  }
}
