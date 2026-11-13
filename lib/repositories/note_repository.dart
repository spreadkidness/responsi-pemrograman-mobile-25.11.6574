import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';
import '../services/secure_storage_service.dart';

/// Coordinates note metadata and encrypted note-content persistence.
class NoteRepository {
  NoteRepository({
    SecureStorageService? secureStorage,
  }) : _secureStorage = secureStorage ?? SecureStorageService();

  static const String _metadataKey = 'course_note_metadata';
  final SecureStorageService _secureStorage;

  /// Loads metadata from SharedPreferences and content from secure storage.
  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_metadataKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    final notes = <Note>[];
    for (final item in decoded) {
      final metadata = Map<String, dynamic>.from(item as Map);
      final id = metadata['id'] as String;
      final content = await _secureStorage.getContent(id) ?? '';
      notes.add(Note.fromMetadataJson(metadata, content: content));
    }
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes;
  }

  /// Adds a note by saving its content securely and metadata as JSON.
  Future<void> addNote(Note note) async {
    await _secureStorage.saveContent(note.id, note.content);
    final notes = await _loadMetadata();
    notes.add(note);
    await _saveMetadata(notes);
  }

  /// Deletes note metadata and its encrypted content.
  Future<void> deleteNote(String noteId) async {
    final notes = await _loadMetadata();
    notes.removeWhere((note) => note.id == noteId);
    await _saveMetadata(notes);
    await _secureStorage.deleteContent(noteId);
  }

  Future<List<Note>> _loadMetadata() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_metadataKey);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List<dynamic>)
        .map((item) => Note.fromMetadataJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  Future<void> _saveMetadata(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notes.map((note) => note.toMetadataJson()).toList());
    await prefs.setString(_metadataKey, encoded);
  }
}
