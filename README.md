# Dutio Mobile

Aplikasi Flutter untuk mengatur jadwal dan tugas piket asrama bagi anggota dan koordinator.

## Menjalankan aplikasi

```shell
flutter pub get
flutter run
```

Tes widget dan analisis statis:

```shell
flutter test
flutter analyze
```

## Alur UI

- **Anggota:** login, beranda, checklist misi, poin/evaluasi, chat koordinator, pengaturan akun, notifikasi, dan unggah laporan piket.
- **Koordinator:** login/daftar, dashboard jadwal, chat anggota, Data Center, pengelolaan area dan kamar, evaluasi laporan, dan pengaturan.
- Halaman khusus yang dibuka dari dashboard memakai named route di `lib/main.dart`. Navigasi tab anggota dan koordinator dipisahkan.

Data akun, jadwal, pesan, evaluasi, dan laporan saat ini hanya contoh untuk UI. Aksi yang memerlukan layanan perangkat atau backend (autentikasi, kamera/galeri sungguhan, panggilan, penyimpanan, dan API) belum dihubungkan. Gambar area kamar mandi yang tersedia untuk prototipe berada di `assets/images/bathroom.png`.

Untuk integrasi Laravel, pindahkan data dummy dari layar ke model/repository, tambahkan konfigurasi base URL dan penanganan respons/error di lapisan data, lalu hubungkan autentikasi dan unggah berkas tanpa mengubah widget layar.
