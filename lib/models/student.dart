/// Represents the editable profile data of a student.
class Student {
  /// Creates a student profile.
  const Student({
    required this.name,
    required this.nim,
    required this.programStudi,
    required this.email,
  });

  final String name;
  final String nim;
  final String programStudi;
  final String email;

  /// Returns a copy with only the supplied fields changed.
  Student copyWith({
    String? name,
    String? nim,
    String? programStudi,
    String? email,
  }) {
    return Student(
      name: name ?? this.name,
      nim: nim ?? this.nim,
      programStudi: programStudi ?? this.programStudi,
      email: email ?? this.email,
    );
  }
}
