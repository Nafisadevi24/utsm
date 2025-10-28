🎬 CineLog+

Aplikasi Catatan Film Pribadi Berbasis Flutter
CineLog+ adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna mencatat, menyimpan, dan mengelola daftar film yang telah atau ingin mereka tonton.
Aplikasi ini mendukung fungsi CRUD penuh (Create, Read, Update, Delete) dan menyimpan data secara lokal menggunakan SharedPreferences dan LocalStorage.

🧩 Fitur Utama
✏️ Tambah, ubah, hapus, dan tampilkan data film
🔍 Pencarian dan pengelompokan film berdasarkan genre
⭐ Daftar favorit otomatis untuk film dengan rating 5 bintang
👤 Login & Signup dengan penyimpanan lokal
📱 Navigasi menggunakan BottomNavigationBar
💾 Data tersimpan permanen di local storage (tidak hilang saat aplikasi ditutup)

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

🧠 Teknologi yang Digunakan
- Flutter SDK
- Dart Programming Language
- SharedPreferences & LocalStorage (penyimpanan lokal)
- Material Icons
- ListView, Card, DropdownButton, dan Form Widget

📁 Lisensi
Proyek ini dibuat untuk keperluan mata kuliah Mobile Programming dan boleh digunakan untuk pembelajaran pribadi.

