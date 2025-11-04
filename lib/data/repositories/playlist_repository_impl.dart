import '../../domain/entities/playlist.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../datasources/remote_scraper.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final RemoteScraper scraper;
  PlaylistRepositoryImpl(this.scraper);

  @override
  Future<Playlist> fetchPlaylistFromUrl(String url) {
    return scraper.scrapePlaylist(url);
  }
}
