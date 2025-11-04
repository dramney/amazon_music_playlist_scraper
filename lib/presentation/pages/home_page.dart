import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/playlist_provider.dart';
import 'playlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController(text: 'https://music.amazon.com/playlists/B07CV25BHL');

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaylistProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Get your playlist')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Playlist URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                provider.loadFromUrl(_controller.text.trim());
              },
              child: const Text('Fetch playlist'),
            ),
            const SizedBox(height: 12),
            Expanded(child: _buildResult(provider)),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(PlaylistProvider provider) {
    switch (provider.state) {
      case LoadingState.idle:
        return const Center(child: Text('Enter playlist URL and press "Fetch playlist".'));
      case LoadingState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadingState.error:
        return Center(child: Text('Error: ${provider.error}'));
      case LoadingState.success:
        if (provider.playlist == null) return const Center(child: Text('No playlist found.'));
        return PlaylistPage(playlist: provider.playlist!);
    }
  }
}
