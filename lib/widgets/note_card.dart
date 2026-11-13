import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';

/// Displays note title, date, and a short content preview.
class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.onDelete});

  final Note note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final preview = note.content.replaceAll('\n', ' ');
    return Card(
      child: ListTile(
        title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${DateFormat('dd/MM/yyyy HH:mm').format(note.date)}\n$preview',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        trailing: IconButton(
          tooltip: 'Hapus catatan',
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
