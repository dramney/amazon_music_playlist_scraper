import 'package:flutter/cupertino.dart';
import '../../data/datasources/remote_scraper.dart';
import '../../data/repositories/playlist_repository_impl.dart';
import '../../core/network/http_client.dart';
import '../../domain/usecases/get_playlist.dart';
import '../../domain/entities/playlist.dart';
import '../../core/error/exceptions.dart';

enum LoadingState { idle, loading, success, error }

class PlaylistProvider with ChangeNotifier {
  LoadingState state = LoadingState.idle;
  Playlist? playlist;
  String? error;

  final _usecase = GetPlaylist(
    PlaylistRepositoryImpl(RemoteScraper(SimpleHttpClient())),
  );

  Future<void> loadFromUrl(String url) async {
    state = LoadingState.loading;
    error = null;
    playlist = null;
    notifyListeners();
    try {
      final p = await _usecase(url);
      playlist = p;
      state = LoadingState.success;
    } on ScraperException catch (e) {
      error = e.message;
      state = LoadingState.error;
    } catch (e) {
      error = 'Виникла невідома помилка: $e';
      state = LoadingState.error;
    }
    notifyListeners();
  }
}