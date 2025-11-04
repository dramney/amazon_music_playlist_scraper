import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/playlist_provider.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: MaterialApp(
        title: 'Playlist Scraper',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}