# 📦 Flutter Project – Skripsi Ficram Manifur Farissa

<p align="center">
  <img src="logo.png" alt="Project Logo" width="120" />
</p>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/Flutter-v3.x-blue?logo=flutter" alt="Flutter"></a>
  <a href="#"><img src="https://img.shields.io/badge/Python-3.x-yellow?logo=python" alt="Python"></a>
  <a href="#"><img src="https://img.shields.io/badge/License-MIT-green" alt="License"></a>
</p>

> 🔧 Proyek skripsi Teknik Elektro: **Asistant Penjadwalan** & **Pilates Member**, dibuat dengan **Flutter** (frontend) dan **Python Flask** (backend).

---

## � **Flowchart Project**

<p align="center">
  <img src="flowchart.png" alt="Flowchart Project" width="500" />
</p>

*(Placeholder: tambahkan file flowchart.png jika sudah ada)*

---

## 🇮🇩 **Deskripsi Singkat (Bahasa Indonesia)**

### 📂 Struktur Project
flutter-project/
├── Asistant Penjadwalan/
│ ├── backend/ # REST API backend (Python Flask)
│ └── frontend/ # Flutter frontend
│
├── Pilates Member/
│ ├── backend/ # REST API backend (Python Flask)
│ └── frontend/ # Flutter frontend
│
├── README.md
└── .gitignore

---

## 🚀 **Fitur Utama**

### ✅ Asistant Penjadwalan
- Login & register
- Tambah & lihat jadwal
- Layanan chat mahasiswa

### ✅ Pilates Member
- Login & register
- Lihat jadwal kelas
- Manajemen keanggotaan
- Integrasi Firebase (auth & database)

---

## ⚙ **Cara Menjalankan (Local)**

### Backend
```bash
# Asistant Penjadwalan
cd "Asistant Penjadwalan/backend"
pip install -r requirements.txt
python app.py

# Pilates Member
cd "Pilates Member/backend"
pip install -r requirements.txt
python main.py

Frontend (Flutter)
cd "Asistant Penjadwalan/frontend"  # atau Pilates Member/frontend
flutter pub get
flutter run

Keamanan
File rahasia seperti firebase-adminsdk.json tidak disertakan di repository. Pastikan file tersebut ada secara lokal untuk kebutuhan development.
