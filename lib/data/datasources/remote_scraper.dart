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
    // print(html);
    final document = parser.parse(html);

    String title = 'Unknown Playlist';
    String description = '';
    String imageUrl = '';

    final titleElement = document.querySelector('head > title');
    if (titleElement != null) {
      title = titleElement.text
          .replaceAll('Playlist on Amazon Music Unlimited', '')
          .replaceAll('Playlist auf Amazon Music Unlimited', '')
          .trim();
    }

    final descriptionElement =
    document.querySelector('meta[name="description"]');
    if (descriptionElement != null) {
      description = descriptionElement.attributes['content'] ?? '';

      String toRemove = "Listen to the $title playlist with Amazon Music Unlimited.";

      description = description.replaceAll(toRemove, '').trim();

    }

    final imgElement =
    document.querySelector('music-detail-header music-image img');
    if (imgElement != null) {
      imageUrl = imgElement.attributes['data-src'] ??
          imgElement.attributes['src'] ??
          '';
    }

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
    final trackName = element.attributes['primary-text'] ?? '';
    if (trackName.isEmpty) return null;

    final artist = element.attributes['secondary-text-1'] ?? '';

    final album = element.attributes['secondary-text-2'] ?? '';

    final imageUrl = element.attributes['image-src'] ?? '';

    String duration = '';
    final durationElement = element.querySelector('.col4 music-link span');
    if (durationElement != null) {
      duration = durationElement.text.trim();
    }

    if (duration.isEmpty) {
      final col4 = element.querySelector('.col4');
      if (col4 != null) {
        final text = col4.text.trim();
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
    return text
        .replaceAll('&amp;', '&')
        .replaceAll('&#39;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll(RegExp(r'\[Explicit\]'), '')
        .replaceAll(RegExp(r'\[explicit\]'), '')
        .trim();
  }
}
