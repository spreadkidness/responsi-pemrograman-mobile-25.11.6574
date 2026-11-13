
import 'package:flutter/material.dart';

import '../providers/app_provider.dart';
import '../models/note.dart';
import 'profile_screen.dart';
import 'note_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    String id,
  ) async {
    final app = AppProvider.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Catatan'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus catatan ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true && context.mounted) {
      app.deleteNote(id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan berhasil dihapus'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = AppProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Kuliah'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profil Mahasiswa',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Informasi mahasiswa
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 251, 252, 252),
                child: Text(
                  app.student.name.isNotEmpty
                      ? app.student.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 3, 3, 3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                app.student.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(app.student.nim),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),

          // Judul daftar catatan
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Catatan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Daftar catatan
          Expanded(
            child: app.notes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada catatan kuliah',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Tekan tombol + untuk menambahkan catatan',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: app.notes.length,
                    itemBuilder: (context, index) {
                      final Note note = app.notes[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.description),
                          ),
                          title: Text(
                            note.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            note.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            tooltip: 'Hapus catatan',
                            onPressed: () {
                              _confirmDelete(
                                context,
                                note.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Catatan',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
