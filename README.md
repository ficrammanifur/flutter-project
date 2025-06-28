# 📦 Flutter Project – Skripsi Ficram Manifur Farissa

<p align="center">
  <!-- Replace logo.png with your actual logo file -->
  <img src="assets/logo.png" alt="Project Logo" width="200" />
  <p align="center">(Project Logo)</p>
</p>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/Flutter-v3.x-blue?logo=flutter" alt="Flutter"></a>
  <a href="#"><img src="https://img.shields.io/badge/Python-3.x-yellow?logo=python" alt="Python"></a>
  <a href="#"><img src="https://img.shields.io/badge/License-MIT-green" alt="License"></a>
</p>

> 🔧 Proyek skripsi Teknik Elektro: **Asistant Penjadwalan** & **Pilates Member**, dibuat dengan **Flutter** (frontend) dan **Python Flask** (backend).

---

## 📊 **Flowchart Project**

<p align="center">
  <!-- Replace flowchart.png with your actual flowchart file -->
  <img src="assets/flowchart.png" alt="Flowchart Project" width="600" />
  <p align="center">(Diagram alur sistem)</p>
</p>

*Pastikan untuk menambahkan file flowchart.png di folder assets jika belum ada*

---

## 📂 **Struktur Project**

```plaintext
flutter-project/
├── Asistant_Penjadwalan/       # Project Assistant Penjadwalan
│   ├── backend/               # REST API backend (Python Flask)
│   └── frontend/              # Flutter frontend
│
├── Pilates_Member/            # Project Pilates Member
│   ├── backend/               # REST API backend (Python Flask)
│   └── frontend/              # Flutter frontend
│
├── assets/                    # Folder untuk gambar/asset
│   ├── logo.png               # Logo project
│   └── flowchart.png          # Diagram alur
│
├── README.md                  # Dokumentasi ini
└── .gitignore                 # File ignore untuk Git
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
