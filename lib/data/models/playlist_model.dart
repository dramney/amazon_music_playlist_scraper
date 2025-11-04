import '../../domain/entities/playlist.dart';
import 'track_model.dart';

class PlaylistModel extends Playlist {
  PlaylistModel({
    required String title,
    required String imageUrl,
    required String description,
    required List<TrackModel> tracks,
  }) : super(title: title, imageUrl: imageUrl, description: description, tracks: tracks);

  factory PlaylistModel.fromParsedData({
    required String title,
    required String imageUrl,
    required String description,
    required List<TrackModel> tracks,
  }) {
    return PlaylistModel(
      title: title,
      imageUrl: imageUrl,
      description: description,
      tracks: tracks,
    );
  }
}
