import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provides encrypted local storage for private note contents.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Saves note content using a note-specific secure key.
  Future<void> saveContent(String noteId, String content) async {
    await _storage.write(key: 'note_content_$noteId', value: content);
  }

  /// Reads the encrypted content for a note.
  Future<String?> getContent(String noteId) {
    return _storage.read(key: 'note_content_$noteId');
  }

  /// Deletes the encrypted content for a note.
  Future<void> deleteContent(String noteId) async {
    await _storage.delete(key: 'note_content_$noteId');
  }
}
