import 'package:flutter/material.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/track.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;
  const PlaylistPage({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: playlist.imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                playlist.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.music_note, size: 40),
              ),
            )
                : const Icon(Icons.music_note, size: 40),
            title: Text(
              playlist.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              playlist.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tracks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(height: 10, thickness: 1),
        Expanded(child: _buildTrackList(playlist.tracks)),
      ],
    );
  }

  Widget _buildTrackList(List<Track> tracks) {
    return ListView.separated(
      itemCount: tracks.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final t = tracks[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: t.imageUrl.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              t.imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.music_note, size: 30),
            ),
          )
              : const Icon(Icons.music_note, size: 30),
          title: Text(
            t.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${t.artist} • ${t.album}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            t.duration,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }
}
