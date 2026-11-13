/// Contains validation and sanitization helpers for user input.
class Validators {
  Validators._();

  /// Validates a note title (3–50 characters).
  static String? validateTitle(String? value) {
    final text = sanitize(value ?? '').trim();
    if (text.isEmpty) return 'Judul wajib diisi.';
    if (text.length < 3) return 'Judul minimal 3 karakter.';
    if (text.length > 50) return 'Judul maksimal 50 karakter.';
    return null;
  }

  /// Validates note content (10–1000 characters).
  static String? validateContent(String? value) {
    final text = sanitize(value ?? '').trim();
    if (text.isEmpty) return 'Isi catatan wajib diisi.';
    if (text.length < 10) return 'Isi catatan minimal 10 karakter.';
    if (text.length > 1000) return 'Isi catatan maksimal 1000 karakter.';
    return null;
  }

  /// Removes the characters less-than, greater-than, double quote and apostrophe.
  static String sanitize(String value) {
    return value.replaceAll(RegExp("[<>\\\"']"), '').trim();
  }
}
