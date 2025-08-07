# ARIMA Analytics Mobile App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20App-blue?style=for-the-badge&logo=flutter" />
  <img src="https://img.shields.io/badge/Python-Flask%20API-green?style=for-the-badge&logo=python" />
  <img src="https://img.shields.io/badge/ARIMA-Machine%20Learning-purple?style=for-the-badge&logo=tensorflow" />
  <img src="https://img.shields.io/badge/REST-API-orange?style=for-the-badge&logo=api" />
</p>

## 🎯 Overview

Aplikasi mobile ARIMA Analytics adalah sistem prediksi bahan baku berbasis machine learning yang menggunakan model ARIMA (AutoRegressive Integrated Moving Average). Aplikasi ini menyediakan dashboard real-time untuk monitoring stok, prediksi kebutuhan bahan baku, dan manajemen inventory dengan antarmuka yang modern dan responsif.

## ✨ Fitur Utama

### 📱 Mobile Interface
- **Real-time Dashboard** - Monitoring statistik penjualan dan stok secara real-time
- **Modern UI** - Desain glassmorphism dengan animasi smooth dan responsive
- **ARIMA Prediction** - Konfigurasi dan eksekusi model prediksi dengan parameter custom
- **Materials Management** - Monitoring stok bahan baku dengan alert system
- **Interactive Charts** - Visualisasi data historis dan hasil prediksi
- **Quick Actions** - Akses cepat ke fitur utama aplikasi

### 🤖 Backend Features
- **Flask REST API** - Backend service dengan endpoint terstruktur
- **ARIMA Model** - Implementasi model prediksi time series
- **Data Processing** - Utilities untuk cleaning dan preprocessing data
- **Mock Data Support** - Fallback data untuk development dan testing
- **Error Handling** - Comprehensive error handling dan logging
- **CORS Support** - Cross-origin resource sharing untuk web integration

## 📋 Requirements

### Mobile Development
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android device atau emulator

### Backend Development
- Python 3.8+
- Flask framework
- NumPy, Pandas untuk data processing
- Virtual environment (recommended)

### Dependencies
\`\`\`yaml
# Flutter dependencies
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  cupertino_icons: ^1.0.2

# Python dependencies
Flask==2.3.3
Flask-CORS==4.0.0
pandas==2.0.3
numpy==1.24.3
scikit-learn==1.3.0
\`\`\`

## 🚀 Installation

### 1. Backend Setup

#### Install Python Dependencies
\`\`\`bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r backend/requirements.txt
\`\`\`

#### Run Flask Server
\`\`\`bash
cd backend
python app.py
\`\`\`
Server akan berjalan di `http://localhost:5000`

### 2. Mobile App Setup

#### Install Flutter Dependencies
\`\`\`bash
# Get Flutter packages
flutter pub get

# Run code generation (if needed)
flutter packages pub run build_runner build
\`\`\`

#### Run Flutter App
\`\`\`bash
# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Build APK
flutter build apk
\`\`\`

## 📡 API Endpoints Structure

### 🔄 GET REST API Flow Diagram

```mermaid
graph TD
    A["📱 Flutter App"]  B["🔄 API Service Call"]
    B  C["📡 HTTP GET Request"]
    C  D["🌐 Network Layer"]
    D  E["🔍 Check Network Connection"]
    
    E |"✅ Connected"| F["📤 Send Request to Server"]
    E |"❌ No Connection"| G["⚠️ Network Error"]
    
    F  H["🖥️ Flask Backend Server"]
    H  I["🛡️ Request Validation"]
    
    I |"✅ Valid"| J["📊 Process Request"]
    I |"❌ Invalid"| K["🚫 400 Bad Request"]
    
    J  L["💾 Data Processing"]
    L  M["📈 Generate Response Data"]
    M  N["📦 JSON Response"]
    
    N  O["📡 HTTP Response"]
    O  P["📱 Flutter Receives Response"]
    
    P  Q["🔍 Status Code Check"]
    
    Q |"200 OK"| R["✅ Parse JSON Data"]
    Q |"4xx/5xx Error"| S["❌ Handle Error"]
    
    R  T["🔄 Update UI State"]
    T  U["📱 Display Data to User"]
    
    S  V["📱 Show Error Message"]
    G  V
    K  V
    
    V  W["🔄 Retry Option"]
    W  B
    
    style A fill:#e1f5fe
    style H fill:#f3e5f5
    style U fill:#e8f5e8
    style V fill:#ffebee
