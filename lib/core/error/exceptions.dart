abstract class ScraperException implements Exception {
  final String message;
  ScraperException(this.message);
  @override
  String toString() => message;
}

class InvalidUrlException extends ScraperException {
  InvalidUrlException(
      [String message =
      'Недійсна URL-адреса. Переконайтеся, що вона починається з "https://music.amazon.com/playlists/".'])
      : super(message);
}

class PlaylistNotFoundException extends ScraperException {
  PlaylistNotFoundException(
      [String message =
      'Плейлист не знайдено. Перевірте URL-адресу або переконайтеся, що плейлист не є приватним.'])
      : super(message);
}

class NetworkException extends ScraperException {
  NetworkException(
      [String message = 'Помилка мережі. Перевірте своє інтернет-з\'єднання.'])
      : super(message);
}

class ParsingException extends ScraperException {
  ParsingException([String message = 'Не вдалося обробити сторінку плейлиста.'])
      : super(message);
}