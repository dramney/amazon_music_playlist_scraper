import 'package:http/http.dart' as http;

import '../error/exceptions.dart';


class SimpleHttpClient {
  final http.Client _client = http.Client();

  Future<String> getPage(String playlistUrl) async {
    final response = await _client.get(
      Uri.parse(playlistUrl),
      headers: {
        'User-Agent': 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'none',
        'Cache-Control': 'max-age=0',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw PlaylistNotFoundException();
    } else {
      throw NetworkException(
          'Помилка завантаження сторінки: ${response.statusCode}');
    }
  }
}
