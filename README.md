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

<img width="250" height="550" alt="Screenshot 2025-10-28 003216" src="https://github.com/user-attachments/assets/1607f27f-8c35-41d9-bb6b-484b2bd2f94e" />



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

> **Catatan akun default:** Terdapat akun contoh yang sudah disertakan di `assets/users.json` —  
> `admin / 12345` dan `nafisa / 12345` (gunakan untuk log in saat pengujian).

🧠 Teknologi yang Digunakan
- Flutter SDK
- Dart Programming Language
- SharedPreferences & LocalStorage (penyimpanan lokal)
- Material Icons
- ListView, Card, DropdownButton, dan Form Widget
<img width="250" height="550" alt="Screenshot 2025-10-28 004822" src="https://github.com/user-attachments/assets/eb5c6790-1299-4b7b-8a13-3d4e1648a138" />
<img width="250" height="550" alt="Screenshot 2025-10-28 005749" src="https://github.com/user-attachments/assets/b976ba43-e7e2-4d21-bb46-5c1f07d24e4c" />

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



