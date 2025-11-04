import '../entities/playlist.dart';

abstract class PlaylistRepository {
  Future<Playlist> fetchPlaylistFromUrl(String url);
}
