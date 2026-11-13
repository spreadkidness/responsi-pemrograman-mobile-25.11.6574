import 'package:flutter/material.dart';

import '../models/note.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';

/// Provides a validated form for creating a course note.
class NoteFormScreen extends StatefulWidget {
  const NoteFormScreen({super.key});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final note = Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: Validators.sanitize(_titleController.text),
      content: Validators.sanitize(_contentController.text),
      date: DateTime.now(),
    );
    try {
      AppProvider.of(context).addNote(note);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan gagal disimpan. Coba lagi.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(labelText: 'Judul catatan'),
              validator: Validators.validateTitle,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              minLines: 6,
              maxLines: 10,
              maxLength: 1000,
              decoration: const InputDecoration(labelText: 'Isi catatan'),
              validator: Validators.validateContent,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: const Icon(Icons.save),
                label: Text(_saving ? 'Menyimpan...' : 'Simpan Catatan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
