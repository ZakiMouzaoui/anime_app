import 'package:anime_app/anime_app.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachedQuery.instance.config(
    config: QueryConfigFlutter(
      refetchOnResume: true,
      refetchOnConnection: true,
      refetchDuration: const Duration(minutes: 5, seconds: 30),
      cacheDuration: const Duration(minutes: 5, seconds: 30)
    )
  );
  runApp(const AnimeApp());
}