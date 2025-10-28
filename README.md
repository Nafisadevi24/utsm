🎬 CineLog+

Aplikasi Catatan Film Pribadi Berbasis Flutter
CineLog+ adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna mencatat, menyimpan, dan mengelola daftar film yang telah atau ingin mereka tonton.
Aplikasi ini mendukung fungsi CRUD penuh (Create, Read, Update, Delete) dan menyimpan data secara lokal menggunakan SharedPreferences dan LocalStorage.

🧩 Fitur Utama
- ✏️ Tambah, ubah, hapus, dan tampilkan data film
- 🔍 Pencarian dan pengelompokan film berdasarkan genre
- ⭐ Daftar favorit otomatis untuk film dengan rating 5 bintang
- 👤 Login & Signup dengan penyimpanan lokal
- 📱 Navigasi menggunakan BottomNavigationBar
- 💾 Data tersimpan permanen di local storage (tidak hilang saat aplikasi ditutup)

Desain Antarmuka (UI Design)
Aplikasi menggunakan tema biru profesional dengan antarmuka sederhana dan responsif.
Hierarki teks dan elemen visual mengikuti gaya Material Design bawaan Flutter.
| Elemen         | Fungsi                           | Warna / Kode |
| -------------- | -------------------------------- | ------------ |
| Warna utama    | AppBar, tombol, ikon aktif       | `#1565C0`    |
| Warna sekunder | Latar belakang                   | `#E3F2FD`    |
| Aksen          | Gradasi dan tombol tambahan      | `#2196F3`    |
| Teks utama     | Judul & isi teks                 | `#0D47A1`    |
| Teks sekunder  | Warna teks putih pada latar biru | `#FFFFFF`    |

lib/
├── main.dart
├── models/
│   ├── movie_model.dart
│   └── user_model.dart
├── repository/
│   └── data_repository.dart
├── pages/
│   ├── splash_page.dart
│   ├── login_page.dart
│   ├── signup_page.dart
│   ├── main_page.dart
│   ├── home_page.dart
│   ├── add_edit_page.dart
│   ├── detail_page.dart
│   └── explore_page.dart
└── widgets/
    └── movie_card.dart
assets/
├── movies.json
├── users.json
└── posters/


🗂️ Struktur Navigasi Aplikasi
| Halaman  | File Dart            | Fungsi Utama                         |
| -------- | -------------------- | ------------------------------------ |
| Splash   | `splash_page.dart`   | Logo dan animasi awal                |
| Login    | `login_page.dart`    | Autentikasi pengguna                 |
| Signup   | `signup_page.dart`   | Registrasi akun baru                 |
| Main     | `main_page.dart`     | Navigasi bawah (BottomNavigationBar) |
| Home     | `home_page.dart`     | Menampilkan semua film               |
| Add/Edit | `add_edit_page.dart` | Form tambah dan edit data film       |
| Detail   | `detail_page.dart`   | Detail lengkap film                  |
| Explore  | `explore_page.dart`  | Film berdasarkan genre               |
| Favorit  | `favorite_page.dart` | Film dengan rating 5                 |
| Akun     | `account_page.dart`  | Profil pengguna & logout             |

🚀 Cara Menjalankan Proyek
- Clone repositori dari GitHub:
git clone https://github.com/username/cinelog_plus.git
cd cinelog_plus
- Install dependencies Flutter:
flutter pub get
- Jalankan aplikasi di emulator atau perangkat fisik:
flutter run

🧠 Teknologi yang Digunakan
- Flutter SDK
- Dart Programming Language
- SharedPreferences & LocalStorage (penyimpanan lokal)
- Material Icons
- ListView, Card, DropdownButton, dan Form Widget

🧪 Hasil Pengujian
- ✅ Login dan registrasi akun berjalan normal
- ✅ Tambah, ubah, hapus film berhasil dan tersimpan di storage
- ✅ Navigasi antartab lancar
- ✅ Data tetap tersimpan setelah aplikasi ditutup
- ⚠️ Kadang data edit belum langsung tampil — akan diperbaiki di versi selanjutnya

Untuk pengembangan selanjutnya, aplikasi dapat ditingkatkan melalui beberapa aspek, 
seperti: Pada tahap pengembangan berikutnya, data aplikasi akan diperbarui melalui permintaan ke server menggunakan API yang disediakan. Selain itu, dilakukan pula optimalisasi antarmuka dengan penambahan mode gelap (dark mode) serta peningkatan tampilan UI agar lebih menarik dan responsif.  

📁 Lisensi
Proyek ini dibuat untuk keperluan mata kuliah Mobile Programming dan boleh digunakan untuk pembelajaran pribadi.

👩‍💻 Pengembang
Nama: Nafisa Devi Nur Rusydah
NIM: 230605110182
Program Studi: Teknik Informatika
Fakultas Sains dan Teknologi
Universitas Islam Negeri Maulana Malik Ibrahim Malang
Semester Ganjil 2025/2026
