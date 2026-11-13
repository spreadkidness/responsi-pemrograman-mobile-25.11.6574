import 'package:flutter/material.dart';

import '../models/student.dart';

/// Displays the student's profile in a reusable card.
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.student, this.compact = false});

  final Student student;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final initial = student.name.trim().isEmpty
        ? '?'
        : student.name.trim().substring(0, 1).toUpperCase();
    return Card(
      color: const Color(0xFFFFE0B2),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: compact ? 25 : 34,
              backgroundColor: Colors.orange,
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('NIM: ${student.nim}'),
                  if (!compact) Text(student.programStudi),
                  if (!compact) Text(student.email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
