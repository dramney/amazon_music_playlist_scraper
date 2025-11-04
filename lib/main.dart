import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/playlist_provider.dart';
import 'presentation/pages/home_page.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
