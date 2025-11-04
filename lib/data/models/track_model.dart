import '../../domain/entities/track.dart';

class TrackModel extends Track {
  TrackModel({
    required String name,
    required String artist,
    required String album,
    required String duration,
    required String imageUrl,
  }) : super(
    name: name,
    artist: artist,
    album: album,
    duration: duration,
    imageUrl: imageUrl,
  );

  factory TrackModel.fromMap(Map<String, String> m) {
    return TrackModel(
      name: m['name'] ?? '',
      artist: m['artist'] ?? '',
      album: m['album'] ?? '',
      duration: m['duration'] ?? '',
      imageUrl: m['imageUrl'] ?? '',
    );
  }
}
