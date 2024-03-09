import 'package:anime_app/anime_app.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CachedQuery.instance.config(
    config: QueryConfigFlutter(
      refetchOnResume: true,
      refetchOnConnection: true,
      refetchDuration: const Duration(minutes: 5, seconds: 30),
      cacheDuration: const Duration(minutes: 5, seconds: 30)
    )
  );
  await dotenv.load(fileName: ".env");
  runApp(const AnimeApp());
}