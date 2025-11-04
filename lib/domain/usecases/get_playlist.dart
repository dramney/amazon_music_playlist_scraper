import '../entities/playlist.dart';
import '../repositories/playlist_repository.dart';

class GetPlaylist {
  final PlaylistRepository repository;
  GetPlaylist(this.repository);

  Future<Playlist> call(String url) async {
    return await repository.fetchPlaylistFromUrl(url);
  }
}
