class ScraperException implements Exception {
  final String message;
  ScraperException(this.message);
  @override
  String toString() => 'ScraperException: $message';
}

