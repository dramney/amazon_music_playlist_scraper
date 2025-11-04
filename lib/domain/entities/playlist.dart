import 'track.dart';

class Playlist {
  final String title;
  final String imageUrl;
  final String description;
  final List<Track> tracks;

  Playlist({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.tracks,
  });
}
