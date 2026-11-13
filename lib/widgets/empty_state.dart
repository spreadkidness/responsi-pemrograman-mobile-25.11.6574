import 'package:flutter/material.dart';

/// Displays a helpful message when there are no saved notes.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.note_alt_outlined, size: 64, color: Colors.grey.shade500),
            const SizedBox(height: 12),
            Text('Belum ada catatan', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            const Text('Tekan tombol + untuk menambahkan catatan kuliah.'),
          ],
        ),
      ),
    );
  }
}
