/// Represents a course note; content is stored separately in secure storage.
class Note {
  /// Creates note metadata and its in-memory content.
  const Note({
    required this.id,
    required this.title,
    required this.date,
    required this.content,
  });

  final String id;
  final String title;
  final DateTime date;
  final String content;

  /// Converts note metadata to JSON without exposing note content.
  Map<String, dynamic> toMetadataJson() => {
        'id': id,
        'title': title,
        'date': date.toIso8601String(),
      };

  /// Recreates note metadata; content is loaded separately.
  factory Note.fromMetadataJson(Map<String, dynamic> json, {String content = ''}) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      content: content,
    );
  }

  /// Returns a copy with updated fields.
  Note copyWith({String? title, DateTime? date, String? content}) {
    return Note(
      id: id,
      title: title ?? this.title,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }
}
