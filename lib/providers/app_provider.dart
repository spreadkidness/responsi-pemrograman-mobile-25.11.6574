import 'package:flutter/material.dart';

import '../models/note.dart';
import '../models/student.dart';
import '../repositories/note_repository.dart';

/// Exposes student and note state to descendant widgets.
class AppProvider extends InheritedWidget {
  const AppProvider({
    super.key,
    required this.student,
    required this.notes,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required super.child,
  });

  final Student student;
  final List<Note> notes;
  final ValueChanged<Student> updateStudent;
  final ValueChanged<Note> addNote;
  final ValueChanged<String> deleteNote;

  /// Returns the nearest provider and subscribes the widget to its updates.
  static AppProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(provider != null, 'AppProvider tidak ditemukan di widget tree.');
    return provider!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return student != oldWidget.student || notes != oldWidget.notes;
  }
}

/// Owns app state and injects it into the widget subtree.
class AppProviderWrapper extends StatefulWidget {
  final Widget child;

  const AppProviderWrapper({
    super.key, 
    required this.child,
    });

  @override
  State<AppProviderWrapper> createState() =>
        _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  final NoteRepository _repository = NoteRepository();
  Student _student = const Student(
    name: 'Nama Mahasiswa',
    nim: 'XXXXXXXX',
    programStudi: 'S1 Informatika',
    email: 'mahasiswa@example.com',
  );
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final loaded = await _repository.loadNotes();
      if (mounted) setState(() => _notes = loaded);
    } catch (_) {
      // Do not log note content or sensitive storage details.
    }
  }

  void _updateStudent(Student student) {
    setState(() => _student = student);
  }

  Future<void> _addNote(Note note) async {
    await _repository.addNote(note);
    if (mounted) setState(() => _notes = [note, ..._notes]);
  }

  Future<void> _deleteNote(String id) async {
    await _repository.deleteNote(id);
    if (mounted) setState(() => _notes = _notes.where((n) => n.id != id).toList());
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: _student,
      notes: _notes,
      updateStudent: _updateStudent,
      addNote: (note) => _addNote(note),
      deleteNote: (id) => _deleteNote(id),
      child: widget.child,
    );
  }
}
