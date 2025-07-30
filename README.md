<h1 align="center">
  📦 Flutter Project – Ficram Manifur Farissa
</h1>


<p align="center">
  <img src="https://img.shields.io/badge/Flutter-v3.x-blue?logo=flutter" alt="Flutter" />
  <img src="https://img.shields.io/badge/Python-3.x-yellow?logo=python" alt="Python" />
  <img src="https://img.shields.io/badge/Backend-Flask-lightgrey?logo=flask" alt="Flask" />
  <img src="https://img.shields.io/badge/Database-Firebase%20%7C%20SQLite-orange?logo=firebase" alt="Firebase | SQLite" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License" />
</p>

> 🔧 Proyek : **Asistant Penjadwalan** & **Pilates Member**, dibuat dengan **Flutter** (frontend) dan **Python Flask** (backend).

---

## 📊 Flowchart Project


---

## 📂 Struktur Project

```plaintext
flutter-project/
├── Asistant_Penjadwalan/       # Project Assistant Penjadwalan
│   ├── backend/               # REST API backend (Python Flask)
│   │   ├── app.py
│   │   └── requirements.txt
│   └── frontend/              # Flutter frontend
│       ├── lib/
│       └── pubspec.yaml
├── Pilates_Member/            # Project Pilates Member
│   ├── backend/               # REST API backend (Python Flask)
│   │   ├── main.py
│   │   └── requirements.txt
│   └── frontend/              # Flutter frontend
│       ├── lib/
│       └── pubspec.yaml
├── assets/                    # Folder untuk gambar/asset
│   ├── logo.png               # Logo project
│   └── flowchart.png          # Diagram alur
├── README.md                  # Dokumentasi ini
└── .gitignore                 # File ignore untuk Git
```

---

## 🚀 Fitur Utama

### ✅ Asistant Penjadwalan

-   **Login & Register**: Sistem autentikasi pengguna.
-   **Tambah & Lihat Jadwal**: Fitur manajemen jadwal.
-   **Layanan Chat Mahasiswa**: Komunikasi antar pengguna.

### ✅ Pilates Member

-   **Login & Register**: Sistem autentikasi pengguna.
-   **Lihat Jadwal Kelas**: Menampilkan jadwal kelas Pilates.
-   **Manajemen Keanggotaan**: Fitur untuk mengelola status keanggotaan.
-   **Integrasi Firebase**: Autentikasi dan database real-time.

---

## ⚙️ Cara Menjalankan (Lokal)

### 1. Backend (Python Flask)

Pastikan Anda memiliki Python 3.x terinstal.

#### Untuk Asistant Penjadwalan:

```bash
cd Asistant_Penjadwalan/backend
pip install -r requirements.txt
python app.py
```

#### Untuk Pilates Member:

```bash
cd Pilates_Member/backend
pip install -r requirements.txt
python main.py
```

### 2. Frontend (Flutter)

Pastikan Anda memiliki Flutter SDK terinstal.

#### Untuk Asistant Penjadwalan:

```bash
cd Asistant_Penjadwalan/frontend
flutter pub get
flutter run
```

#### Untuk Pilates Member:

```bash
cd Pilates_Member/frontend
flutter pub get
flutter run
```

---

## 🔒 Catatan Keamanan

File konfigurasi sensitif seperti `firebase-adminsdk.json` **tidak termasuk** dalam repository ini. Pastikan untuk:

-   Menyimpan file tersebut secara lokal.
-   Menambahkannya ke `.gitignore`.
-   **Tidak mengunggahnya ke repositori publik.**

---

## 🛠️ Teknologi yang Digunakan

### Frontend
-   **Flutter**: UI Framework
-   **Dart**: Bahasa Pemrograman

### Backend
-   **Python**: Bahasa Pemrograman
-   **Flask**: Web Framework

### Database
-   **Firebase Realtime Database**: Untuk Pilates Member
-   **SQLite**: Untuk Asistant Penjadwalan (jika digunakan secara lokal)

### Lain-lain
-   **REST API**: Komunikasi antara frontend dan backend
-   **Git & GitHub**: Version Control
-   **VS Code / Android Studio**: IDE

---

## 🐛 Troubleshooting

### Backend tidak berjalan
-   Pastikan semua dependensi Python terinstal (`pip install -r requirements.txt`).
-   Cek port yang digunakan oleh Flask, pastikan tidak ada konflik.
-   Periksa log konsol untuk pesan error.

### Frontend tidak terhubung ke backend
-   Pastikan backend Flask sudah berjalan.
-   Verifikasi alamat IP/URL backend di kode Flutter Anda.
-   Cek firewall jika ada masalah koneksi.

### Error saat `flutter pub get`
-   Pastikan koneksi internet stabil.
-   Coba `flutter clean` lalu `flutter pub get` lagi.
-   Periksa versi Flutter dan Dart Anda.

---

## 🔮 Roadmap

-   [ ] Implementasi notifikasi push untuk jadwal.
-   [ ] Fitur pembayaran untuk keanggotaan Pilates.
-   [ ] Integrasi kalender eksternal (Google Calendar, dll.).
-   [ ] Peningkatan UI/UX dengan animasi yang lebih kompleks.
-   [ ] Penambahan fitur laporan dan analisis data.
-   [ ] Migrasi database ke PostgreSQL/MySQL untuk skala yang lebih besar.

---

## 🤝 Kontribusi

Kontribusi dalam bentuk *pull request*, laporan *bug*, atau saran sangat diterima. Silakan buka *issue* atau *pull request* di repositori ini.

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

## 👨‍💻 Author

**Ficram Manifur Farissa**
-   [GitHub](https://github.com/ficrammanifur)
-   [Portfolio](https://ficrammanifur.github.io/ficram-portfolio/)

<div align="center">
  <b>⭐ Beri bintang pada repository ini jika Anda merasa terbantu! ⭐</b>
  <p><a href="#top">⬆ Kembali ke Atas</a></p>
</div>
