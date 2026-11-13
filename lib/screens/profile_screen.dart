import 'package:flutter/material.dart';

import '../models/student.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';
import '../widgets/profile_card.dart';

/// Shows and edits the current student's profile.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _nim;
  late final TextEditingController _program;
  late final TextEditingController _email;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final student = AppProvider.of(context).student;
    _name = TextEditingController(text: student.name);
    _nim = TextEditingController(text: student.nim);
    _program = TextEditingController(text: student.programStudi);
    _email = TextEditingController(text: student.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _nim.dispose();
    _program.dispose();
    _email.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    AppProvider.of(context).updateStudent(Student(
      name: Validators.sanitize(_name.text),
      nim: Validators.sanitize(_nim.text),
      programStudi: Validators.sanitize(_program.text),
      email: _email.text.trim(),
    ));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final student = AppProvider.of(context).student;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileCard(student: student),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Nama'), validator: (v) => (v == null || v.trim().length < 3) ? 'Nama minimal 3 karakter.' : null),
                const SizedBox(height: 12),
                TextFormField(controller: _nim, decoration: const InputDecoration(labelText: 'NIM'), validator: (v) => (v == null || v.trim().isEmpty) ? 'NIM wajib diisi.' : null),
                const SizedBox(height: 12),
                TextFormField(controller: _program, decoration: const InputDecoration(labelText: 'Program Studi'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Program studi wajib diisi.' : null),
                const SizedBox(height: 12),
                TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email'), validator: (v) => (v == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim())) ? 'Format email tidak valid.' : null),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: const Text('Simpan Profil'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
