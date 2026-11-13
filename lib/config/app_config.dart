import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Holds application configuration loaded from the local .env file.
class AppConfig {
  AppConfig._();

  static late String baseUrl;
  static late String apiKey;

  /// Reads configuration values after dotenv has been initialized.
  static void initialize() {
    baseUrl = dotenv.env['BASE_URL'] ?? 'https://jsonplaceholder.typicode.com';
    apiKey = dotenv.env['API_KEY'] ?? '';
  }
}
