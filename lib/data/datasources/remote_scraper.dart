import 'package:html/parser.dart' as parser;
import '../../core/error/exceptions.dart';
import '../../core/network/http_client.dart';
import '../models/playlist_model.dart';
import '../models/track_model.dart';

class RemoteScraper {
  final SimpleHttpClient client;
  RemoteScraper(this.client);

  Future<PlaylistModel> scrapePlaylist(String url) async {
    final html = await client.getPage(url);
    final document = parser.parse(html);

    // Extract playlist metadata from music-detail-header
    String title = 'Unknown Playlist';
    String description = '';
    String imageUrl = '';

    final detailHeader = document.querySelector('music-detail-header');
    if (detailHeader != null) {
      title = detailHeader.attributes['headline'] ??
          detailHeader.attributes['primary-text'] ??
          'Unknown Playlist';
      description = detailHeader.attributes['secondary-text'] ?? '';
      imageUrl = detailHeader.attributes['image-src'] ?? '';
    }

    // Extract tracks from music-image-row elements
    final tracks = <TrackModel>[];
    final trackElements = document.querySelectorAll('music-image-row[data-key]');

    for (var trackElement in trackElements) {
      try {
        final trackData = _parseTrackElement(trackElement);
        if (trackData != null) {
          tracks.add(trackData);
        }
      } catch (e) {
        print('Error parsing track: $e');
        continue;
      }
    }

    if (tracks.isEmpty) {
      throw ScraperException('No tracks found in playlist');
    }

    return PlaylistModel.fromParsedData(
      title: title,
      description: description,
      imageUrl: imageUrl,
      tracks: tracks,
    );
  }

  TrackModel? _parseTrackElement(dynamic element) {
    // Get track name from primary-text attribute
    final trackName = element.attributes['primary-text'] ?? '';
    if (trackName.isEmpty) return null;

    // Get artist from secondary-text-1 attribute
    final artist = element.attributes['secondary-text-1'] ?? '';

    // Get album from secondary-text-2 attribute
    final album = element.attributes['secondary-text-2'] ?? '';

    // Get image URL from image-src attribute
    final imageUrl = element.attributes['image-src'] ?? '';

    // Get duration from the duration span inside
    String duration = '';
    final durationElement = element.querySelector('.col4 music-link span');
    if (durationElement != null) {
      duration = durationElement.text.trim();
    }

    // If duration not found in span, try to extract from col4
    if (duration.isEmpty) {
      final col4 = element.querySelector('.col4');
      if (col4 != null) {
        final text = col4.text.trim();
        // Duration pattern: MM:SS
        final durationMatch = RegExp(r'\d{1,2}:\d{2}').firstMatch(text);
        if (durationMatch != null) {
          duration = durationMatch.group(0) ?? '';
        }
      }
    }

    return TrackModel(
      name: _cleanText(trackName),
      artist: _cleanText(artist),
      album: _cleanText(album),
      duration: duration,
      imageUrl: imageUrl,
    );
  }

  String _cleanText(String text) {
    // Remove HTML entities and extra whitespace
    return text
        .replaceAll('&amp;', '&')
        .replaceAll('&#39;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll(RegExp(r'\[Explicit\]'), '')
        .replaceAll(RegExp(r'\[explicit\]'), '')
        .trim();
  }
}
