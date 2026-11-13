# Responsi Pemrograman Mobile ST407

Aplikasi Profil Mahasiswa dengan Catatan Kuliah.

## Menjalankan aplikasi

1. Pastikan Flutter dan Git sudah terpasang.
2. Pastikan file `.env` tersedia di root proyek. Contoh isi tersedia di `.env.example`.
3. Jalankan:

```bash
flutter pub get
flutter run
```

## Android

Di `android/app/src/main/AndroidManifest.xml`, tambahkan permission berikut tepat di dalam tag `<manifest>` dan sebelum `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

Di dalam tag `<application>`, pastikan atribut `android:allowBackup="false"` ada. Jangan membuat tag `<application>` kedua.

## Git sesuai instruksi responsi

```bash
git init
git add .
git commit -m "chore: buat struktur awal proyek Flutter"

git switch -c fitur-profil
git add lib/models/student.dart lib/screens/profile_screen.dart lib/widgets/profile_card.dart
git commit -m "feat: implementasi profil mahasiswa"
git switch main

git switch -c fitur-catatan
git add lib/models/note.dart lib/screens/note_form_screen.dart lib/widgets/note_card.dart lib/widgets/empty_state.dart lib/repositories/note_repository.dart lib/services/secure_storage_service.dart lib/utils/validators.dart
git commit -m "feat: implementasi catatan dan penyimpanan aman"
git switch main
git merge fitur-profil
git merge fitur-catatan

git add .
git commit -m "feat: integrasi dashboard dan request HTTP"
git log --graph --oneline --all
```

Jika branch default Git lokal bernama `master`, ubah nama menjadi `main` setelah `git init`:

```bash
git branch -M main
```

## Catatan implementasi

- Metadata catatan (id, judul, tanggal) disimpan sebagai JSON di SharedPreferences.
- Isi catatan disimpan melalui flutter_secure_storage.
- `API_KEY` dimuat dari `.env` sebagai contoh konfigurasi; endpoint JSONPlaceholder publik tidak memerlukan API key.
- Jangan commit `.env`; `.gitignore` sudah mengabaikannya. Simpan `.env.example` sebagai contoh konfigurasi.
- Logging tidak menampilkan isi catatan, token, atau data sensitif.
- Dependency `http` ditambahkan karena soal meminta request HTTP GET.
