<h1 align="center">🚀 Multi-App Development Suite</h1>
<h2 align="center">Ficram Manifur Farissa</h2>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Flask-2.0+-000000?style=for-the-badge&logo=flask&logoColor=white" alt="Flask" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
  <img src="https://img.shields.io/badge/XAMPP-FB7A24?style=for-the-badge&logo=xampp&logoColor=white" alt="XAMPP" />
</p>

<p align="center">
  <strong>🔧 3 Aplikasi Lengkap: Assistant Penjadwalan, PastryStock & Pilates Member</strong><br>
  Dibuat dengan <strong>Flutter</strong> (frontend) dan <strong>Python Flask</strong> (backend)
</p>

<p align="center">
  <a href="#-aplikasi-overview">Aplikasi</a> •
  <a href="#-cara-menjalankan">Instalasi</a> •
  <a href="#-database-setup">Database</a> •
  <a href="#-teknologi">Teknologi</a> •
  <a href="#-troubleshooting">Troubleshooting</a>
</p>

---

## 📊 Arsitektur Multi-App

```mermaid
graph TB
    subgraph "Frontend Layer - Flutter Mobile Apps"
        A1[Assistant Penjadwalan]
        A2[PastryStock Management]
        A3[Pilates Member]
    end
    
    subgraph "Backend Layer - Flask APIs"
        B1[Schedule API<br/>Python Flask]
        B2[PastryStock API<br/>Python Flask + ARIMA]
        B3[Pilates API<br/>Python Flask]
    end
    
    subgraph "Database Layer"
        C1[XAMPP MySQL<br/>Local Database]
        C2[Firebase Realtime DB<br/>Cloud Database]
        C3[Firebase Realtime DB<br/>Cloud Database]
    end
    
    A1  B1
    A2  B2
    A3  B3
    
    B1  C1
    B2  C2
    B3  C3
    
    style A1 fill:#4CAF50,stroke:#fff,color:#fff
    style A2 fill:#FF9800,stroke:#fff,color:#fff
    style A3 fill:#9C27B0,stroke:#fff,color:#fff
    style B1 fill:#2196F3,stroke:#fff,color:#fff
    style B2 fill:#FF5722,stroke:#fff,color:#fff
    style B3 fill:#E91E63,stroke:#fff,color:#fff
    style C1 fill:#00BCD4,stroke:#fff,color:#fff
    style C2 fill:#FFCA28,stroke:#000,color:#000
    style C3 fill:#FFCA28,stroke:#000,color:#000

# PastryStock Backend API

<p align="center">
  <img src="https://img.shields.io/badge/Flask-API-blue?style=for-the-badge&logo=flask" />
  <img src="https://img.shields.io/badge/Firebase-Database-orange?style=for-the-badge&logo=firebase" />
  <img src="https://img.shields.io/badge/Python-3.8+-green?style=for-the-badge&logo=python" />
  <img src="https://img.shields.io/badge/ARIMA-Prediction-purple?style=for-the-badge&logo=python" />
</p>

## 🎯 Overview

PastryStock Backend is a Flask-based REST API for managing a pastry shop's inventory, sales, and user authentication. It integrates with Firebase for real-time database operations, uses bcrypt for password hashing, and incorporates Google Gemini AI for advanced features. The backend also includes ARIMA-based stock prediction capabilities.

## ✨ Key Features

### 🔐 Authentication & Authorization
- **JWT-based Authentication** - Secure token-based auth system
- **User Registration & Login** - Complete user management
- **Password Reset** - Email-based password recovery
- **Role-based Access Control** - Admin and user roles

### 📊 Sales Management
- **Real-time Sales Tracking** - Track daily sales performance
- **Sales Analytics** - Generate sales reports and insights
- **Menu Item Management** - Manage bakery menu items
- **Revenue Calculation** - Automatic revenue calculations

### 📦 Inventory Management
- **Stock Monitoring** - Real-time stock level tracking
- **Low Stock Alerts** - Automated notifications for low inventory
- **Consumption Tracking** - Track ingredient usage patterns
- **Stock Updates** - Manual and automatic stock adjustments

### 🔮 AI-Powered Predictions
- **ARIMA Forecasting** - Advanced time series prediction
- **Stock Optimization** - Predict optimal stock levels
- **Demand Forecasting** - Predict future ingredient needs
- **Gemini AI Integration** - Enhanced prediction accuracy

## 🛠️ Tech Stack

| Component | Technology | Version |
|-----------|------------|---------|
| **Framework** | Flask | 2.3.0+ |
| **Database** | Firebase Realtime DB | Latest |
| **Authentication** | Firebase Auth | Latest |
| **Password Hashing** | bcrypt | 4.0+ |
| **AI/ML** | Google Gemini AI | Latest |
| **Time Series** | statsmodels | 0.14+ |
| **Data Processing** | pandas, numpy | Latest |
| **Environment** | python-dotenv | Latest |
| **CORS** | Flask-CORS | Latest |

## 📋 Requirements

### System Requirements
- **Python**: 3.8 or higher
- **Memory**: Minimum 512MB RAM
- **Storage**: 100MB free space
- **Network**: Internet connection for Firebase

### Dependencies
```txt
Flask==2.3.2
firebase-admin==6.2.0
bcrypt==4.0.1
google-generativeai==0.3.0
statsmodels==0.14.0
pandas==2.0.3
numpy==1.24.3
python-dotenv==1.0.0
Flask-CORS==4.0.0
requests==2.31.0
```

## 🚀 Installation & Setup

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/pastrystock-backend.git
cd pastrystock-backend
```

### 2. Create Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\\Scripts\\activate
# On macOS/Linux:
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing
3. Generate service account key:
   - Go to Project Settings > Service Accounts
   - Click "Generate new private key"
   - Save as `serviceAccountKey.json` in project root

### 5. Environment Configuration
Create `.env` file in project root:
```env
# Firebase Configuration
FIREBASE_CREDENTIALS=serviceAccountKey.json
FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com/

# Google Gemini AI
GEMINI_API_KEY=your-gemini-api-key-here

# Flask Configuration
FLASK_DEBUG=TRUE
FLASK_ENV=development
PORT=5000

# Security
SECRET_KEY=your-super-secret-key-here
JWT_SECRET_KEY=your-jwt-secret-key-here

# CORS Settings
CORS_ORIGINS=http://localhost:3000,http://localhost:8080
```

### 6. Initialize Database
```bash
# Run database initialization script
python init_db.py
```

### 7. Start Server
```bash
python app.py
```

Server will start at `http://localhost:5000`

## 📡 API Endpoints

### 🔐 Authentication Endpoints

#### POST /api/auth/login
Login user with email and password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "user123",
      "name": "John Doe",
      "email": "user@example.com",
      "role": "user"
    }
  }
}
```

#### POST /api/auth/signup
Register new user account.

**Request:**
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "role": "user"
}
```

#### POST /api/auth/reset-password
Send password reset email.

**Request:**
```json
{
  "email": "user@example.com"
}
```

### 👤 User Management

#### GET /api/users/profile
Get current user profile (requires authentication).

**Headers:**
```
Authorization: Bearer <jwt_token>
```

#### PUT /api/users/profile
Update user profile (requires authentication).

**Request:**
```json
{
  "name": "Updated Name",
  "email": "newemail@example.com"
}
```

### 💰 Sales Endpoints

#### GET /api/sales/recent
Get 10 most recent sales (requires authentication).

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "sale123",
      "menuName": "Muffin",
      "quantity": 10,
      "pricePerItem": 20000,
      "totalAmount": 200000,
      "date": "2025-07-31T10:30:00Z"
    }
  ]
}
```

#### GET /api/sales/today
Get today's sales summary.

#### POST /api/sales
Add new sale record.

**Request:**
```json
{
  "menuName": "Croissant",
  "quantity": 5,
  "pricePerItem": 35000
}
```

### 📦 Inventory Endpoints

#### GET /api/ingredients
Get all ingredients with stock levels.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "ing001",
      "ingredientName": "Keju",
      "currentStock": 150,
      "unit": "gram",
      "dailyConsumption": 45,
      "minThreshold": 100,
      "status": "sufficient",
      "recommendation": "Stock sufficient for 3 days"
    }
  ]
}
```

#### GET /api/ingredients/low-stock
Get ingredients with low stock levels.

#### PUT /api/ingredients/{id}/stock
Update ingredient stock level.

**Request:**
```json
{
  "currentStock": 200,
  "operation": "add"
}
```

#### POST /api/ingredients
Add new ingredient.

**Request:**
```json
{
  "ingredientName": "Vanilla Extract",
  "currentStock": 500,
  "unit": "ml",
  "minThreshold": 100,
  "dailyConsumption": 25
}
```

### 🔮 Prediction Endpoints

#### GET /api/predictions
Generate stock predictions for all ingredients.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "ingredientId": "ing001",
      "ingredientName": "Keju",
      "currentStock": 150,
      "predictedConsumption": [45, 47, 44, 46, 48, 45, 43],
      "predictedStock": [105, 58, 14, -32, -80, -125, -168],
      "daysUntilEmpty": 3,
      "recommendedOrder": 200,
      "confidence": 0.85
    }
  ]
}
```

#### GET /api/predictions/{id}/arima
Get ARIMA-based prediction for specific ingredient.

#### GET /api/predictions/{id}/history
Get prediction history for ingredient.

### 🍰 Menu Endpoints

#### GET /api/menu-items
Get all menu items.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "menu001",
      "name": "Muffin",
      "price": 20000,
      "category": "pastry",
      "ingredients": ["ing001", "ing002", "ing003"]
    }
  ]
}
```

### 🏥 Health Check

#### GET /api/ping
Check server status.

#### GET /
Welcome message with ASCII art.

## 🗄️ Database Schema

### Users Collection
```json
{
  "users": {
    "userId123": {
      "name": "John Doe",
      "email": "user@example.com",
      "password_hash": "$2b$12$...",
      "role": "user",
      "created_at": "2025-01-20T10:30:00Z"
    }
  }
}
```

### Sales Collection
```json
{
  "sales": {
    "saleId123": {
      "menuName": "Muffin",
      "quantity": 10,
      "pricePerItem": 20000,
      "totalAmount": 200000,
      "date": "2025-01-20T10:30:00Z",
      "userId": "userId123"
    }
  }
}
```

### Ingredients Collection
```json
{
  "ingredients": {
    "ingredientId123": {
      "ingredientName": "Keju",
      "currentStock": 150,
      "unit": "gram",
      "dailyConsumption": 45,
      "minThreshold": 100,
      "status": "sufficient",
      "recommendation": "Stock sufficient for 3 days",
      "consumptionHistory": {
        "historyId1": {
          "date": "2025-01-20",
          "consumption": 45
        }
      }
    }
  }
}
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `FIREBASE_CREDENTIALS` | Path to Firebase service account key | `serviceAccountKey.json` |
| `FIREBASE_DATABASE_URL` | Firebase Realtime Database URL | `https://project.firebaseio.com` |
| `GEMINI_API_KEY` | Google Gemini AI API key | `AIza....` |
| `FLASK_DEBUG` | Enable Flask debug mode | `TRUE` |
| `PORT` | Server port | `5000` |
| `SECRET_KEY` | Flask secret key | `your-secret-key` |
| `JWT_SECRET_KEY` | JWT signing key | `jwt-secret-key` |

### Firebase Security Rules
```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    },
    "sales": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "ingredients": {
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}
```

## 🧪 Testing

### Run Unit Tests
```bash
python -m pytest tests/ -v
```

### Run Integration Tests
```bash
python -m pytest tests/integration/ -v
```

### Test Coverage
```bash
python -m pytest --cov=app tests/
```

## 📊 Performance Optimization

### Database Optimization
- Use Firebase indexing for frequently queried fields
- Implement pagination for large datasets
- Cache frequently accessed data
- Use batch operations for multiple writes

### API Optimization
```python
# Example: Caching with Flask-Caching
from flask_caching import Cache

cache = Cache(app, config={'CACHE_TYPE': 'simple'})

@app.route('/api/ingredients')
@cache.cached(timeout=300)  # Cache for 5 minutes
def get_ingredients():
    return get_all_ingredients()
```

### ARIMA Model Optimization
```python
# Optimize ARIMA parameters
from statsmodels.tsa.arima.model import ARIMA
import warnings
warnings.filterwarnings('ignore')

def optimize_arima_params(data):
    best_aic = float('inf')
    best_params = None
    
    for p in range(3):
        for d in range(2):
            for q in range(3):
                try:
                    model = ARIMA(data, order=(p, d, q))
                    fitted = model.fit()
                    if fitted.aic < best_aic:
                        best_aic = fitted.aic
                        best_params = (p, d, q)
                except:
                    continue
    
    return best_params
```

## 🔒 Security Best Practices

### Authentication Security
- Use strong JWT secrets
- Implement token expiration
- Hash passwords with bcrypt
- Validate all input data

### API Security
```python
from functools import wraps
import jwt

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token:
            return {'message': 'Token missing'}, 401
        
        try:
            token = token.split(' ')[1]  # Remove 'Bearer '
            data = jwt.decode(token, app.config['JWT_SECRET_KEY'], algorithms=['HS256'])
        except:
            return {'message': 'Token invalid'}, 401
        
        return f(*args, **kwargs)
    return decorated
```

### Firebase Security
- Enable Firebase Authentication
- Set up proper security rules
- Use HTTPS only
- Implement rate limiting

## 🚀 Deployment

### Docker Deployment
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 5000

CMD ["python", "app.py"]
```

### Heroku Deployment
```bash
# Install Heroku CLI
heroku create pastrystock-backend
heroku config:set FIREBASE_DATABASE_URL=your-url
heroku config:set GEMINI_API_KEY=your-key
git push heroku main
```

### Production Environment
```bash
# Use production WSGI server
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

## 🐛 Troubleshooting

### Common Issues

#### Firebase Connection Error
```bash
# Check Firebase credentials
export GOOGLE_APPLICATION_CREDENTIALS="serviceAccountKey.json"
python -c "import firebase_admin; print('Firebase OK')"
```

#### ARIMA Prediction Errors
```python
# Ensure sufficient data points
if len(consumption_data) < 7:
    return {"error": "Insufficient data for ARIMA prediction"}
```

#### Memory Issues
```bash
# Monitor memory usage
pip install memory-profiler
python -m memory_profiler app.py
```

## 📈 Monitoring & Logging

### Application Logging
```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('app.log'),
        logging.StreamHandler()
    ]
)
```

### Performance Monitoring
```python
from flask import request
import time

@app.before_request
def before_request():
    request.start_time = time.time()

@app.after_request
def after_request(response):
    duration = time.time() - request.start_time
    app.logger.info(f'{request.method} {request.path} - {response.status_code} - {duration:.3f}s')
    return response
```

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Make changes and add tests
4. Run tests: `python -m pytest`
5. Commit changes: `git commit -m 'Add amazing feature'`
6. Push to branch: `git push origin feature/amazing-feature`
7. Create Pull Request

### Code Style
- Follow PEP 8 guidelines
- Use type hints where possible
- Add docstrings to functions
- Write unit tests for new features

### Testing Guidelines
```python
import unittest
from app import app

class TestAPI(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True
    
    def test_ping_endpoint(self):
        response = self.app.get('/api/ping')
        self.assertEqual(response.status_code, 200)
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Firebase Team** for excellent real-time database
- **Flask Community** for the amazing web framework
- **Google AI** for Gemini API integration
- **statsmodels** for ARIMA implementation
- **Open Source Community** for various libraries

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/yourusername/pastrystock-backend/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/pastrystock-backend/discussions)
- **Email**: support@pastrystock.com
- **Documentation**: [API Docs](https://api.pastrystock.com/docs)

## 🔗 Useful Links

- [Flask Documentation](https://flask.palletsprojects.com/)
- [Firebase Admin SDK](https://firebase.google.com/docs/admin/setup)
- [Google Gemini AI](https://ai.google.dev/)
- [ARIMA Tutorial](https://www.statsmodels.org/stable/examples/notebooks/generated/tsa_arma_0.html)

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

Made with ❤️ for the bakery community

</div>
# PastryStock Frontend - Flutter Mobile App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20App-blue?style=for-the-badge&logo=flutter" />
  <img src="https://img.shields.io/badge/Dart-Language-green?style=for-the-badge&logo=dart" />
  <img src="https://img.shields.io/badge/Material-Design-orange?style=for-the-badge&logo=material-design" />
  <img src="https://img.shields.io/badge/ARIMA-Predictions-purple?style=for-the-badge&logo=tensorflow" />
</p>

## 🎯 Overview

PastryStock adalah aplikasi mobile Flutter untuk manajemen stok dan penjualan yang dirancang khusus untuk UMKM bakery/pastry skala kecil-menengah. Aplikasi ini dilengkapi dengan prediksi ARIMA untuk optimalisasi inventory management dan antarmuka yang user-friendly.

## ✨ Fitur Utama

### 📊 Dashboard Interaktif
- **Real-time Monitoring** - Data penjualan dan stok terupdate otomatis
- **Grafik Penjualan** - Visualisasi penjualan 7 hari terakhir
- **Top Menu Items** - 5 menu terlaris dengan performa penjualan
- **Status Stok Visual** - Indikator warna (hijau/kuning/merah) untuk level stok
- **Notifikasi Push** - Alert otomatis untuk stok menipis

### 💰 Manajemen Penjualan
- **Input Penjualan Cepat** - Interface intuitif untuk input penjualan harian
- **5 Menu Utama**:
  - 🧁 Madaline
  - 🧁 Muffin  
  - 🧁 Mini Muffin
  - 🍰 Cheesecake
  - 🍪 Sable Cookies
- **Tracking Historis** - Riwayat penjualan lengkap dengan filter tanggal
- **Kalkulasi Otomatis** - Total penjualan dan revenue dihitung otomatis
- **Export Data** - Export laporan penjualan ke Excel/PDF

### 📦 Manajemen Stok Premium
- **8 Bahan Baku Premium**:
  - 🧀 Keju Premium
  - 🥛 Susu UHT Greenfields
  - ☕ Creamer
  - 🍯 Gula Pasir
  - 🍫 Dark Cokelat
  - 🥛 Yogurt
  - 🍵 Matcha Bubuk
  - 🫖 Earl Grey
- **Update Stok Real-time** - Sinkronisasi otomatis dengan backend
- **Status Visual** - Indikator level stok dengan progress bar
- **History Tracking** - Riwayat penggunaan bahan baku

### 🔮 Prediksi ARIMA Cerdas
- **Prediksi Kebutuhan** - Estimasi kebutuhan stok berdasarkan pola historis
- **Waktu Habis Stok** - Prediksi kapan stok akan habis (dalam hari)
- **Rekomendasi Pemesanan** - Saran jumlah dan waktu optimal untuk restock
- **Model ARIMA** - AutoRegressive Integrated Moving Average untuk akurasi tinggi
- **Confidence Interval** - Tingkat kepercayaan prediksi
- **Trend Analysis** - Analisis tren konsumsi jangka panjang

### ⚙️ Pengaturan Lengkap
- **Mode Demo** - Data dummy untuk testing dan demo
- **Konfigurasi Server** - Setting backend API endpoint
- **Export/Import** - Backup dan restore data
- **Reset Data** - Reset data demo dengan satu klik
- **Theme Settings** - Light/Dark mode support
- **Language Support** - Multi-bahasa (Indonesia/English)

## 🛠️ Teknologi & Arsitektur

### Frontend Stack
| Component | Technology | Version |
|-----------|------------|---------|
| **Framework** | Flutter | 3.7.2+ |
| **Language** | Dart | 3.0+ |
| **UI Framework** | Material Design 3 | Latest |
| **State Management** | Provider + StatefulWidget | Latest |
| **HTTP Client** | http package | 1.1.0+ |
| **Charts** | fl_chart | 0.63.0+ |
| **Local Storage** | shared_preferences | 2.2.0+ |
| **Notifications** | flutter_local_notifications | 15.1.0+ |

### Architecture Pattern
```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
├─────────────────────────────────────────────────────────────┤
│  Screens/Pages  │  Widgets  │  Dialogs  │  Bottom Sheets   │
├─────────────────────────────────────────────────────────────┤
│                     Business Logic Layer                    │
├─────────────────────────────────────────────────────────────┤
│   Services   │   Models   │   Providers   │   Utils        │
├─────────────────────────────────────────────────────────────┤
│                      Data Layer                            │
├─────────────────────────────────────────────────────────────┤
│  API Service │ Local Storage │ Cache Manager │ Preferences │
└─────────────────────────────────────────────────────────────┘
```

## 📱 Persyaratan Sistem

### Development Environment
- **Flutter SDK**: 3.7.2 atau lebih baru
- **Dart SDK**: 3.0 atau lebih baru
- **Android Studio**: 2022.3.1+ atau VS Code dengan Flutter extension
- **Xcode**: 14.0+ (untuk iOS development)
- **Git**: Untuk version control

### Target Devices
- **Android**: 5.0 (API level 21) atau lebih baru
- **iOS**: 11.0 atau lebih baru
- **RAM**: Minimum 2GB, Recommended 4GB+
- **Storage**: 100MB untuk aplikasi + data
- **Network**: Internet connection untuk sinkronisasi data

### Permissions Required
```xml
 Android Permissions 
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

## 🚀 Installation & Setup

### 1. Prerequisites Setup
```bash
# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

### 2. Clone Repository
```bash
git clone https://github.com/yourusername/pastrystock-frontend.git
cd pastrystock-frontend
```

### 3. Install Dependencies
```bash
# Get Flutter packages
flutter pub get

# For iOS (if developing for iOS)
cd ios && pod install && cd ..
```

### 4. Configuration Setup

#### Create `lib/config/app_config.dart`:
```dart
class AppConfig {
  static const String baseUrl = 'http://localhost:5000/api';
  static const String appName = 'PastryStock';
  static const String version = '1.0.0';
  static const bool enableDemo = true;
  static const int requestTimeout = 30; // seconds
  
  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String salesEndpoint = '/sales';
  static const String ingredientsEndpoint = '/ingredients';
  static const String predictionsEndpoint = '/predictions';
}
```

#### Update `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="PastryStock"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher"
    android:usesCleartextTraffic="true">
    
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
        
        <meta-data
          android:name="io.flutter.embedding.android.NormalTheme"
          android:resource="@style/NormalTheme" />
          
        <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
</application>
```

### 5. Run Application
```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Run on specific device
flutter devices
flutter run -d <device_id>
```

## 📂 Project Structure

```
lib/
├── main.dart                    # Entry point
├── config/
│   ├── app_config.dart         # App configuration
│   ├── theme_config.dart       # Theme settings
│   └── route_config.dart       # Route definitions
├── screens/
│   ├── splash_screen.dart      # Splash screen
│   ├── auth/
│   │   ├── login_screen.dart   # Login page
│   │   └── register_screen.dart # Registration page
│   ├── dashboard/
│   │   └── dashboard_screen.dart # Main dashboard
│   ├── sales/
│   │   ├── sales_screen.dart   # Sales management
│   │   └── sales_history_screen.dart # Sales history
│   ├── inventory/
│   │   ├── inventory_screen.dart # Stock management
│   │   └── ingredient_detail_screen.dart # Ingredient details
│   ├── predictions/
│   │   ├── predictions_screen.dart # ARIMA predictions
│   │   └── prediction_detail_screen.dart # Detailed predictions
│   └── settings/
│       └── settings_screen.dart # App settings
├── widgets/
│   ├── common/
│   │   ├── custom_app_bar.dart # Reusable app bar
│   │   ├── loading_widget.dart # Loading indicators
│   │   ├── error_widget.dart   # Error displays
│   │   └── empty_state_widget.dart # Empty state
│   ├── dashboard/
│   │   ├── sales_chart_widget.dart # Sales chart
│   │   ├── stock_status_widget.dart # Stock status
│   │   └── quick_actions_widget.dart # Quick action buttons
│   ├── sales/
│   │   ├── sales_form_widget.dart # Sales input form
│   │   └── sales_item_widget.dart # Sales list item
│   ├── inventory/
│   │   ├── ingredient_card_widget.dart # Ingredient card
│   │   └── stock_level_widget.dart # Stock level indicator
│   └── predictions/
│       ├── prediction_chart_widget.dart # Prediction chart
│       └── recommendation_widget.dart # Recommendations
├── models/
│   ├── user_model.dart         # User data model
│   ├── sales_model.dart        # Sales data model
│   ├── ingredient_model.dart   # Ingredient data model
│   ├── prediction_model.dart   # Prediction data model
│   └── api_response_model.dart # API response wrapper
├── services/
│   ├── api_service.dart        # HTTP API service
│   ├── auth_service.dart       # Authentication service
│   ├── sales_service.dart      # Sales operations
│   ├── inventory_service.dart  # Inventory operations
│   ├── prediction_service.dart # Prediction operations
│   ├── local_storage_service.dart # Local data storage
│   └── notification_service.dart # Push notifications
├── providers/
│   ├── auth_provider.dart      # Authentication state
│   ├── sales_provider.dart     # Sales state management
│   ├── inventory_provider.dart # Inventory state management
│   └── theme_provider.dart     # Theme state management
├── utils/
│   ├── constants.dart          # App constants
│   ├── helpers.dart           # Helper functions
│   ├── validators.dart        # Input validators
│   ├── formatters.dart        # Data formatters
│   └── extensions.dart        # Dart extensions
└── assets/
    ├── images/
    │   ├── logo.png           # App logo
    │   ├── splash_bg.png      # Splash background
    │   └── icons/             # Custom icons
    ├── fonts/                 # Custom fonts
    └── data/
        └── demo_data.json     # Demo data for testing
```

## 🎨 UI/UX Design System

### Color Palette
```dart
class AppColors {
  // Primary Colors - Warm Bakery Theme
  static const Color primary = Color(0xFF8B4513);        // Saddle Brown
  static const Color primaryLight = Color(0xFFD2691E);   // Chocolate
  static const Color primaryDark = Color(0xFF654321);    // Dark Brown
  
  // Secondary Colors
  static const Color secondary = Color(0xFFDEB887);      // Burlywood
  static const Color secondaryLight = Color(0xFFF5DEB3); // Wheat
  static const Color secondaryDark = Color(0xFFCD853F);  // Peru
  
  // Background Colors
  static const Color background = Color(0xFFF5F5DC);     // Beige
  static const Color surface = Color(0xFFFFFFFF);        // White
  static const Color surfaceDark = Color(0xFF2C2C2C);    // Dark Surface
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);        // Green
  static const Color warning = Color(0xFFFF9800);        // Orange
  static const Color error = Color(0xFFF44336);          // Red
  static const Color info = Color(0xFF2196F3);           // Blue
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);    // Dark Gray
  static const Color textSecondary = Color(0xFF757575);  // Medium Gray
  static const Color textHint = Color(0xFFBDBDBD);       // Light Gray
}
```

### Typography
```dart
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
```

### Component Themes
```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(0xFF8B4513, {
      50: Color(0xFFF3E5AB),
      100: Color(0xFFE6CC85),
      200: Color(0xFFD9B366),
      300: Color(0xFFCC9A47),
      400: Color(0xFFBF8128),
      500: Color(0xFF8B4513),
      600: Color(0xFF7A3C11),
      700: Color(0xFF69330F),
      800: Color(0xFF582A0D),
      900: Color(0xFF47210B),
    }),
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
```

## 📊 State Management

### Provider Pattern Implementation
```dart
// Sales Provider Example
class SalesProvider with ChangeNotifier {
  List<Sale> _sales = [];
  bool _isLoading = false;
  String? _error;
  
  List<Sale> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchSales() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService.getSales();
      _sales = response.data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> addSale(Sale sale) async {
    try {
      final response = await ApiService.addSale(sale);
      _sales.insert(0, response.data);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
```

### Provider Setup in main.dart
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

## 🔌 API Integration

### API Service Implementation
```dart
class ApiService {
  static const String baseUrl = AppConfig.baseUrl;
  static final http.Client _client = http.Client();
  
  static Future<ApiResponse<T>> _makeRequest<T>(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }
      
      // Add auth token if available
      final token = await AuthService.getToken();
      if (token != null) {
        defaultHeaders['Authorization'] = 'Bearer $token';
      }
      
      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(url, headers: defaultHeaders);
          break;
        case 'POST':
          response = await _client.post(
            url,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'PUT':
          response = await _client.put(
            url,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(url, headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
      
      final responseData = json.decode(response.body);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.success(
          data: fromJson != null ? fromJson(responseData['data']) : responseData['data'],
          message: responseData['message'],
        );
      } else {
        return ApiResponse<T>.error(
          message: responseData['message'] ?? 'Unknown error occurred',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<T>.error(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
  
  // Sales API methods
  static Future<ApiResponse<List<Sale>>> getSales() async {
    return _makeRequest<List<Sale>>(
      'GET',
      '/sales',
      fromJson: (data) => (data as List).map((item) => Sale.fromJson(item)).toList(),
    );
  }
  
  static Future<ApiResponse<Sale>> addSale(Sale sale) async {
    return _makeRequest<Sale>(
      'POST',
      '/sales',
      body: sale.toJson(),
      fromJson: (data) => Sale.fromJson(data),
    );
  }
  
  // Ingredients API methods
  static Future<ApiResponse<List<Ingredient>>> getIngredients() async {
    return _makeRequest<List<Ingredient>>(
      'GET',
      '/ingredients',
      fromJson: (data) => (data as List).map((item) => Ingredient.fromJson(item)).toList(),
    );
  }
  
  // Predictions API methods
  static Future<ApiResponse<List<Prediction>>> getPredictions() async {
    return _makeRequest<List<Prediction>>(
      'GET',
      '/predictions',
      fromJson: (data) => (data as List).map((item) => Prediction.fromJson(item)).toList(),
    );
  }
}
```

## 📊 ARIMA Prediction Implementation

### Prediction Model
```dart
class Prediction {
  final String ingredientId;
  final String ingredientName;
  final String unit;
  final double currentStock;
  final List<double> predictedConsumption;
  final List<double> predictedStock;
  final int daysUntilEmpty;
  final double recommendedOrder;
  final double confidence;
  final Map<String, dynamic> modelParams;
  final DateTime predictionDate;
  
  Prediction({
    required this.ingredientId,
    required this.ingredientName,
    required this.unit,
    required this.currentStock,
    required this.predictedConsumption,
    required this.predictedStock,
    required this.daysUntilEmpty,
    required this.recommendedOrder,
    required this.confidence,
    required this.modelParams,
    required this.predictionDate,
  });
  
  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      ingredientId: json['ingredientId'],
      ingredientName: json['ingredientName'],
      unit: json['unit'],
      currentStock: json['currentStock'].toDouble(),
      predictedConsumption: List<double>.from(json['predictedConsumption']),
      predictedStock: List<double>.from(json['predictedStock']),
      daysUntilEmpty: json['daysUntilEmpty'],
      recommendedOrder: json['recommendedOrder'].toDouble(),
      confidence: json['confidence'].toDouble(),
      modelParams: json['modelParams'],
      predictionDate: DateTime.parse(json['predictionDate']),
    );
  }
}
```

### Prediction Chart Widget
```dart
class PredictionChartWidget extends StatelessWidget {
  final Prediction prediction;
  
  const PredictionChartWidget({Key? key, required this.prediction}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediksi Stok - ${prediction.ingredientName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}${prediction.unit}');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Hari ${value.toInt()}');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    // Current stock line
                    LineChartBarData(
                      spots: _generateCurrentStockSpots(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                    // Predicted stock line
                    LineChartBarData(
                      spots: _generatePredictedStockSpots(),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildPredictionSummary(context),
          ],
        ),
      ),
    );
  }
  
  List<FlSpot> _generateCurrentStockSpots() {
    // Generate spots for current stock visualization
    return List.generate(7, (index) {
      return FlSpot(index.toDouble(), prediction.currentStock);
    });
  }
  
  List<FlSpot> _generatePredictedStockSpots() {
    // Generate spots for predicted stock
    return List.generate(prediction.predictedStock.length, (index) {
      return FlSpot(index.toDouble(), prediction.predictedStock[index]);
    });
  }
  
  Widget _buildPredictionSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Stok akan habis dalam:'),
            Text(
              '${prediction.daysUntilEmpty} hari',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: prediction.daysUntilEmpty <= 3 ? Colors.red : Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rekomendasi pemesanan:'),
            Text(
              '${prediction.recommendedOrder.toInt()} ${prediction.unit}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tingkat kepercayaan:'),
            Text(
              '${(prediction.confidence * 100).toInt()}%',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
```

## 🧪 Testing

### Unit Testing
```dart
// test/models/sales_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pastrystock/models/sales_model.dart';

void main() {
  group('Sales Model Tests', () {
    test('should create Sale from JSON correctly', () {
      final json = {
        'id': 'sale123',
        'menuName': 'Muffin',
        'quantity': 10,
        'pricePerItem': 20000,
        'totalAmount': 200000,
        'date': '2025-01-20T10:30:00Z',
      };
      
      final sale = Sale.fromJson(json);
      
      expect(sale.id, 'sale123');
      expect(sale.menuName, 'Muffin');
      expect(sale.quantity, 10);
      expect(sale.pricePerItem, 20000);
      expect(sale.totalAmount, 200000);
    });
    
    test('should convert Sale to JSON correctly', () {
      final sale = Sale(
        id: 'sale123',
        menuName: 'Muffin',
        quantity: 10,
        pricePerItem: 20000,
        totalAmount: 200000,
        date: DateTime.parse('2025-01-20T10:30:00Z'),
      );
      
      final json = sale.toJson();
      
      expect(json['id'], 'sale123');
      expect(json['menuName'], 'Muffin');
      expect(json['quantity'], 10);
    });
  });
}
```

### Widget Testing
```dart
// test/widgets/sales_form_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pastrystock/widgets/sales/sales_form_widget.dart';

void main() {
  group('Sales Form Widget Tests', () {
    testWidgets('should display all menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalesFormWidget(
              onSubmit: (sale) {},
            ),
          ),
        ),
      );
      
      expect(find.text('Muffin'), findsOneWidget);
      expect(find.text('Croissant'), findsOneWidget);
      expect(find.text('Cheesecake'), findsOneWidget);
    });
    
    testWidgets('should validate quantity input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalesFormWidget(
              onSubmit: (sale) {},
            ),
          ),
        ),
      );
      
      // Enter invalid quantity
      await tester.enterText(find.byType(TextFormField).first, '-1');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      expect(find.text('Quantity must be greater than 0'), findsOneWidget);
    });
  });
}
```

### Integration Testing
```dart
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pastrystock/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('App Integration Tests', () {
    testWidgets('complete sales flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to sales screen
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      
      // Add a sale
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      
      // Fill form
      await tester.enterText(find.byType(TextFormField).first, '5');
      await tester.tap(find.text('Muffin'));
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();
      
      // Verify sale was added
      expect(find.text('Penjualan berhasil ditambahkan'), findsOneWidget);
    });
  });
}
```

### Run Tests
```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run tests with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📱 Build & Deployment

### Android Build
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Build
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Build for App Store
flutter build ipa --release
```

### Build Configuration
```yaml
# android/app/build.gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        applicationId "com.pastrystock.app"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        
        multiDexEnabled true
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

## 🔧 Performance Optimization

### Image Optimization
```dart
// Use cached network images
import 'package:cached_network_image.dart';

Widget buildOptimizedImage(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
    memCacheWidth: 300,
    memCacheHeight: 300,
  );
}
```

### List Performance
```dart
// Use ListView.builder for large lists
Widget buildOptimizedList(List<Sale> sales) {
  return ListView.builder(
    itemCount: sales.length,
    itemBuilder: (context, index) {
      return SaleItemWidget(sale: sales[index]);
    },
  );
}
```

### State Management Optimization
```dart
// Use Selector for specific state updates
class SalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SalesProvider, bool>(
      selector: (context, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return CircularProgressIndicator();
        }
        return SalesListWidget();
      },
    );
  }
}
```

## 🔒 Security Best Practices

### Secure Storage
```dart
import 'package:flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
```

### Input Validation
```dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
  
  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Quantity must be greater than 0';
    }
    return null;
  }
}
```

## 🐛 Troubleshooting

### Common Issues

#### Build Errors
```bash
# Clean build cache
flutter clean
flutter pub get

# Reset iOS pods
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..

# Fix Android build issues
cd android && ./gradlew clean && cd ..
```

#### Network Issues
```dart
// Add network security config for Android
// android/app/src/main/res/xml/network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">localhost</domain>
        <domain includeSubdomains="true">10.0.2.2</domain>
    </domain-config>
</network-security-config>
```

#### Performance Issues
```dart
// Enable performance overlay
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false; // Set to true for debugging
  runApp(MyApp());
}
```

## 📈 Analytics & Monitoring

### Crash Reporting
```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set up Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  runApp(MyApp());
}
```

### Performance Monitoring
```dart
import 'package:firebase_performance/firebase_performance.dart';

class ApiService {
  static Future<void> trackApiCall(String endpoint) async {
    final trace = FirebasePerformance.instance.newTrace('api_call_$endpoint');
    await trace.start();
    
    try {
      // Make API call
      await _makeApiCall(endpoint);
    } finally {
      await trace.stop();
    }
  }
}
```

## 🤝 Contributing

### Development Guidelines
1. Follow Flutter/Dart style guide
2. Write comprehensive tests
3. Update documentation
4. Use meaningful commit messages
5. Create feature branches

### Code Review Checklist
- [ ] Code follows style guidelines
- [ ] Tests are included and passing
- [ ] Documentation is updated
- [ ] Performance impact is considered
- [ ] Security best practices are followed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Material Design** for UI/UX guidelines
- **Firebase** for backend services
- **Chart Libraries** for data visualization
- **Open Source Community** for various packages

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/yourusername/pastrystock-frontend/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/pastrystock-frontend/discussions)
- **Email**: support@pastrystock.com
- **Documentation**: [Flutter Docs](https://docs.flutter.dev/)

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

Made with ❤️ using Flutter

</div>

-- PastryStock Database Schema
-- Firebase Realtime Database SQL Equivalent

-- Users
-- PastryStock Database Schema
-- Firebase Realtime Database SQL Equivalent

-- Users Table
CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sales Table
CREATE TABLE sales (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    menu_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_per_item DECIMAL(10,2) NOT NULL CHECK (price_per_item > 0),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_sales_date (date),
    INDEX idx_sales_menu (menu_name),
    INDEX idx_sales_user (user_id)
);

-- Ingredients Table
CREATE TABLE ingredients (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL UNIQUE,
    current_stock DECIMAL(10,2) NOT NULL DEFAULT 0,
    unit VARCHAR(50) NOT NULL,
    daily_consumption DECIMAL(10,2) DEFAULT 0,
    min_threshold DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('sufficient', 'low', 'critical') DEFAULT 'sufficient',
    recommendation TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ingredients_status (status),
    INDEX idx_ingredients_stock (current_stock)
);

-- Consumption History Table
CREATE TABLE consumption_history (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_id VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    consumption DECIMAL(10,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    UNIQUE KEY unique_ingredient_date (ingredient_id, date),
    INDEX idx_consumption_date (date),
    INDEX idx_consumption_ingredient (ingredient_id)
);

-- Predictions Table
CREATE TABLE predictions (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_id VARCHAR(255) NOT NULL,
    ingredient_name VARCHAR(255) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    current_stock DECIMAL(10,2) NOT NULL,
    predicted_consumption JSON NOT NULL,
    predicted_stock JSON NOT NULL,
    days_until_empty INT DEFAULT 0,
    recommended_order DECIMAL(10,2) DEFAULT 0,
    confidence DECIMAL(3,2) DEFAULT 0.00,
    model_params JSON,
    accuracy_metrics JSON,
    confidence_interval JSON,
    seasonal_component JSON,
    trend_direction ENUM('increasing', 'decreasing', 'stable') DEFAULT 'stable',
    prediction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    INDEX idx_predictions_ingredient (ingredient_id),
    INDEX idx_predictions_date (prediction_date)
);

-- Menu Items Table
CREATE TABLE menu_items (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category VARCHAR(100) DEFAULT 'pastry',
    description TEXT,
    ingredients JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_menu_category (category),
    INDEX idx_menu_active (is_active)
);

-- User Sessions Table (for JWT token management)
CREATE TABLE user_sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_sessions_user (user_id),
    INDEX idx_sessions_expires (expires_at)
);

-- Insert Default Data
INSERT INTO users (id, name, email, password_hash, role) VALUES
('admin123', 'Admin User', 'admin@pastrystock.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.PmvlG.', 'admin'),
('user123', 'Demo User', 'demo@pastrystock.com', '$2b$12$z0d6my4FAprjSKWNnibBsOC4.dOxXLkfHrhvzmDSmL61A12QCCBei', 'user');

INSERT INTO menu_items (id, name, price, category, description) VALUES
('menu001', 'Muffin', 20000.00, 'pastry', 'Delicious chocolate muffin'),
('menu002', 'Mini Muffin', 15000.00, 'pastry', 'Small sized muffin'),
('menu003', 'Cheesecake', 35000.00, 'cake', 'Creamy cheesecake slice'),
('menu004', 'Sable Cookies', 25000.00, 'cookies', 'Buttery sable cookies'),
('menu005', 'Croissant', 18000.00, 'pastry', 'Flaky butter croissant');

INSERT INTO ingredients (id, ingredient_name, current_stock, unit, daily_consumption, min_threshold, status) VALUES
('ing001', 'Keju', 500.00, 'gram', 45.00, 100.00, 'sufficient'),
('ing002', 'Susu UHT Greenfields', 2000.00, 'ml', 150.00, 500.00, 'sufficient'),
('ing003', 'Creamer', 800.00, 'gram', 60.00, 200.00, 'sufficient'),
('ing004', 'Gula', 1500.00, 'gram', 120.00, 300.00, 'sufficient'),
('ing005', 'Dark Cokelat', 300.00, 'gram', 25.00, 100.00, 'sufficient'),
('ing006', 'Yogurt', 1000.00, 'gram', 80.00, 250.00, 'sufficient'),
('ing007', 'Matcha Bubuk', 200.00, 'gram', 15.00, 50.00, 'sufficient'),
('ing008', 'Earl Grey', 150.00, 'gram', 10.00, 30.00, 'sufficient');

-- Insert Sample Consumption History (last 30 days)
INSERT INTO consumption_history (id, ingredient_id, date, consumption) VALUES
-- Keju consumption
('hist001', 'ing001', '2025-01-01', 45.0),
('hist002', 'ing001', '2025-01-02', 47.0),
('hist003', 'ing001', '2025-01-03', 43.0),
('hist004', 'ing001', '2025-01-04', 46.0),
('hist005', 'ing001', '2025-01-05', 48.0),
('hist006', 'ing001', '2025-01-06', 44.0),
('hist007', 'ing001', '2025-01-07', 45.0),
-- Susu UHT consumption
('hist008', 'ing002', '2025-01-01', 150.0),
('hist009', 'ing002', '2025-01-02', 155.0),
('hist010', 'ing002', '2025-01-03', 148.0),
('hist011', 'ing002', '2025-01-04', 152.0),
('hist012', 'ing002', '2025-01-05', 160.0),
('hist013', 'ing002', '2025-01-06', 145.0),
('hist014', 'ing002', '2025-01-07', 150.0);

-- Insert Sample Sales Data
INSERT INTO sales (id, user_id, menu_name, quantity, price_per_item, total_amount, date) VALUES
('sale001', 'user123', 'Muffin', 10, 20000.00, 200000.00, '2025-01-07 10:30:00'),
('sale002', 'user123', 'Croissant', 5, 18000.00, 90000.00, '2025-01-07 11:15:00'),
('sale003', 'user123', 'Cheesecake', 3, 35000.00, 105000.00, '2025-01-07 14:20:00'),
('sale004', 'user123', 'Sable Cookies', 8, 25000.00, 200000.00, '2025-01-07 16:45:00'),
('sale005', 'user123', 'Mini Muffin', 15, 15000.00, 225000.00, '2025-01-06 09:30:00'),
('sale006', 'user123', 'Muffin', 12, 20000.00, 240000.00, '2025-01-06 13:20:00'),
('sale007', 'user123', 'Croissant', 7, 18000.00, 126000.00, '2025-01-06 15:10:00');

-- Create Views for Common Queries
CREATE VIEW daily_sales_summary AS
SELECT 
    DATE(date) as sale_date,
    COUNT(*) as total_transactions,
    SUM(quantity) as total_items_sold,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_transaction_value
FROM sales 
GROUP BY DATE(date)
ORDER BY sale_date DESC;

CREATE VIEW low_stock_ingredients AS
SELECT 
    id,
    ingredient_name,
    current_stock,
    unit,
    min_threshold,
    ROUND((current_stock / daily_consumption), 1) as days_remaining,
    status
FROM ingredients 
WHERE current_stock <= min_threshold OR status IN ('low', 'critical')
ORDER BY current_stock ASC;

CREATE VIEW top_selling_items AS
SELECT 
    menu_name,
    COUNT(*) as order_count,
    SUM(quantity) as total_quantity_sold,
    SUM(total_amount) as total_revenue,
    AVG(price_per_item) as avg_price
FROM sales 
WHERE date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY menu_name
ORDER BY total_revenue DESC;

-- Stored Procedures
DELIMITER //

CREATE PROCEDURE UpdateIngredientStock(
    IN p_ingredient_id VARCHAR(255),
    IN p_stock_change DECIMAL(10,2),
    IN p_operation ENUM('add', 'subtract')
)
BEGIN
    DECLARE current_stock_val DECIMAL(10,2);
    DECLARE new_stock DECIMAL(10,2);
    DECLARE min_threshold_val DECIMAL(10,2);
    DECLARE new_status VARCHAR(20);
    
    -- Get current stock and threshold
    SELECT current_stock, min_threshold 
    INTO current_stock_val, min_threshold_val
    FROM ingredients 
    WHERE id = p_ingredient_id;
    
    -- Calculate new stock
    IF p_operation = 'add' THEN
        SET new_stock = current_stock_val + p_stock_change;
    ELSE
        SET new_stock = current_stock_val - p_stock_change;
    END IF;
    
    -- Determine new status
    IF new_stock <= 0 THEN
        SET new_status = 'critical';
    ELSEIF new_stock <= min_threshold_val THEN
        SET new_status = 'low';
    ELSE
        SET new_status = 'sufficient';
    END IF;
    
    -- Update ingredient
    UPDATE ingredients 
    SET 
        current_stock = new_stock,
        status = new_status,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_ingredient_id;
    
END //

CREATE PROCEDURE AddDailyConsumption(
    IN p_ingredient_id VARCHAR(255),
    IN p_date DATE,
    IN p_consumption DECIMAL(10,2)
)
BEGIN
    -- Insert or update consumption history
    INSERT INTO consumption_history (id, ingredient_id, date, consumption)
    VALUES (UUID(), p_ingredient_id, p_date, p_consumption)
    ON DUPLICATE KEY UPDATE 
        consumption = p_consumption,
        created_at = CURRENT_TIMESTAMP;
    
    -- Update daily consumption average (last 7 days)
    UPDATE ingredients 
    SET daily_consumption = (
        SELECT AVG(consumption) 
        FROM consumption_history 
        WHERE ingredient_id = p_ingredient_id 
        AND date >= DATE_SUB(p_date, INTERVAL 7 DAY)
    )
    WHERE id = p_ingredient_id;
    
END //

DELIMITER ;

-- Triggers
DELIMITER //

CREATE TRIGGER update_ingredient_status 
AFTER UPDATE ON ingredients
FOR EACH ROW
BEGIN
    DECLARE recommendation_text TEXT;
    DECLARE days_remaining DECIMAL(5,1);
    
    -- Calculate days remaining
    IF NEW.daily_consumption > 0 THEN
        SET days_remaining = NEW.current_stock / NEW.daily_consumption;
    ELSE
        SET days_remaining = 999;
    END IF;
    
    -- Generate recommendation
    IF NEW.status = 'critical' THEN
        SET recommendation_text = CONCAT('URGENT: Stock critically low! Order immediately. Estimated ', ROUND(days_remaining, 1), ' days remaining.');
    ELSEIF NEW.status = 'low' THEN
        SET recommendation_text = CONCAT('Stock running low. Consider ordering soon. Estimated ', ROUND(days_remaining, 1), ' days remaining.');
    ELSE
        SET recommendation_text = CONCAT('Stock sufficient for approximately ', ROUND(days_remaining, 1), ' days.');
    END IF;
    
    -- Update recommendation
    UPDATE ingredients 
    SET recommendation = recommendation_text 
    WHERE id = NEW.id;
    
END //

CREATE TRIGGER log_sales_consumption
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    -- This would typically update ingredient consumption based on recipe
    -- For demo purposes, we'll just log the sale date
    INSERT INTO consumption_history (id, ingredient_id, date, consumption)
    SELECT 
        CONCAT('auto_', UUID()),
        'ing001', -- Keju (example)
        DATE(NEW.date),
        CASE NEW.menu_name
            WHEN 'Muffin' THEN NEW.quantity * 5.0
            WHEN 'Cheesecake' THEN NEW.quantity * 15.0
            WHEN 'Croissant' THEN NEW.quantity * 3.0
            ELSE NEW.quantity * 2.0
        END
    ON DUPLICATE KEY UPDATE 
        consumption = consumption + VALUES(consumption);
        
END //

DELIMITER ;

-- Indexes for Performance
CREATE INDEX idx_sales_date_menu ON sales(date, menu_name);
CREATE INDEX idx_consumption_ingredient_date ON consumption_history(ingredient_id, date);
CREATE INDEX idx_predictions_ingredient_date ON predictions(ingredient_id, prediction_date);
CREATE INDEX idx_ingredients_name_status ON ingredients(ingredient_name, status);

-- Full Text Search Indexes
ALTER TABLE ingredients ADD FULLTEXT(ingredient_name, recommendation);
ALTER TABLE menu_items ADD FULLTEXT(name, description);
[V0_FILE]json:file="database/firebase_structure.json" type="code" isMerged="true"
{
  "pastrystock": {
    "users": {
      "mmUafQaIuxMAyCBphal7kZuaRzH2": {
        "created_at": "2025-01-20T02:10:23.259143",
        "email": "demo@pastrystock.com",
        "name": "Demo User",
        "password_hash": "$2b$12$z0d6my4FAprjSKWNnibBsOC4.dOxXLkfHrhvzmDSmL61A12QCCBei",
        "role": "user",
        "profile": {
          "avatar_url": "",
          "phone": "",
          "address": "",
          "preferences": {
            "theme": "light",
            "language": "id",
            "notifications": true
          }
        }
      },
      "adminUser123ABC": {
        "created_at": "2025-01-15T08:30:00.000000",
        "email": "admin@pastrystock.com",
        "name": "Admin User",
        "password_hash": "$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.PmvlG.",
        "role": "admin",
        "profile": {
          "avatar_url": "https://example.com/avatar.jpg",
          "phone": "+62812345678",
          "address": "Jakarta, Indonesia",
          "preferences": {
            "theme": "dark",
            "language": "en",
            "notifications": true
          }
        }
      }
    },
    "sales": {
      "OTxyremGFYozQTbxdWF": {
        "date": "2025-01-07T06:17:46.147072",
        "menuName": "Muffin",
        "pricePerItem": 20000,
        "quantity": 10,
        "totalAmount": 200000,
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "metadata": {
          "paymentMethod": "cash",
          "customerName": "Walk-in Customer",
          "notes": "Regular customer order"
        }
      },
      "OUVeNZmDdVCiGbTrQ4Q": {
        "date": "2025-01-07T23:54:56.701469",
        "menuName": "Croissant",
        "pricePerItem": 18000,
        "quantity": 5,
        "totalAmount": 90000,
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "metadata": {
          "paymentMethod": "digital",
          "customerName": "John Doe",
          "notes": "Online order"
        }
      },
      "OUVko6RfxropiAmPSNQ": {
        "date": "2025-01-08T00:23:01.949467",
        "menuName": "Cheesecake",
        "pricePerItem": 35000,
        "quantity": 2,
        "totalAmount": 70000,
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "metadata": {
          "paymentMethod": "card",
          "customerName": "Jane Smith",
          "notes": "Birthday cake order"
        }
      },
      "saleABC123DEF456": {
        "date": "2025-01-08T10:15:30.123456",
        "menuName": "Sable Cookies",
        "pricePerItem": 25000,
        "quantity": 8,
        "totalAmount": 200000,
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "metadata": {
          "paymentMethod": "cash",
          "customerName": "Corporate Order",
          "notes": "Bulk order for office meeting"
        }
      },
      "saleXYZ789GHI012": {
        "date": "2025-01-08T14:45:15.987654",
        "menuName": "Mini Muffin",
        "pricePerItem": 15000,
        "quantity": 15,
        "totalAmount": 225000,
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "metadata": {
          "paymentMethod": "digital",
          "customerName": "Sarah Wilson",
          "notes": "Party order"
        }
      }
    },
    "ingredients": {
      "ing001_keju": {
        "ingredientName": "Keju",
        "currentStock": 450.5,
        "unit": "gram",
        "dailyConsumption": 45.2,
        "minThreshold": 100,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 10 days",
        "supplier": {
          "name": "Dairy Fresh Supplier",
          "contact": "+62812345678",
          "email": "supplier@dairyfresh.com"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "M12345": {
            "consumption": 45.0,
            "date": "2025-01-01"
          },
          "M12346": {
            "consumption": 47.2,
            "date": "2025-01-02"
          },
          "M12347": {
            "consumption": 43.8,
            "date": "2025-01-03"
          },
          "M12348": {
            "consumption": 46.1,
            "date": "2025-01-04"
          },
          "M12349": {
            "consumption": 48.5,
            "date": "2025-01-05"
          },
          "M12350": {
            "consumption": 44.3,
            "date": "2025-01-06"
          },
          "M12351": {
            "consumption": 45.7,
            "date": "2025-01-07"
          },
          "M12352": {
            "consumption": 42.9,
            "date": "2025-01-08"
          }
        }
      },
      "ing002_susu": {
        "ingredientName": "Susu UHT Greenfields",
        "currentStock": 1850.0,
        "unit": "ml",
        "dailyConsumption": 152.3,
        "minThreshold": 500,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 12 days",
        "supplier": {
          "name": "Greenfields Distributor",
          "contact": "+62823456789",
          "email": "order@greenfields.co.id"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "H23456": {
            "consumption": 150.0,
            "date": "2025-01-01"
          },
          "H23457": {
            "consumption": 155.5,
            "date": "2025-01-02"
          },
          "H23458": {
            "consumption": 148.2,
            "date": "2025-01-03"
          },
          "H23459": {
            "consumption": 152.8,
            "date": "2025-01-04"
          },
          "H23460": {
            "consumption": 160.1,
            "date": "2025-01-05"
          },
          "H23461": {
            "consumption": 145.7,
            "date": "2025-01-06"
          },
          "H23462": {
            "consumption": 151.3,
            "date": "2025-01-07"
          },
          "H23463": {
            "consumption": 149.6,
            "date": "2025-01-08"
          }
        }
      },
      "ing003_creamer": {
        "ingredientName": "Creamer",
        "currentStock": 720.0,
        "unit": "gram",
        "dailyConsumption": 58.7,
        "minThreshold": 200,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 12 days",
        "supplier": {
          "name": "Indofood Distributor",
          "contact": "+62834567890",
          "email": "sales@indofood.com"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "C34567": {
            "consumption": 60.0,
            "date": "2025-01-01"
          },
          "C34568": {
            "consumption": 58.3,
            "date": "2025-01-02"
          },
          "C34569": {
            "consumption": 59.1,
            "date": "2025-01-03"
          },
          "C34570": {
            "consumption": 57.8,
            "date": "2025-01-04"
          },
          "C34571": {
            "consumption": 60.5,
            "date": "2025-01-05"
          },
          "C34572": {
            "consumption": 56.9,
            "date": "2025-01-06"
          },
          "C34573": {
            "consumption": 58.2,
            "date": "2025-01-07"
          },
          "C34574": {
            "consumption": 59.7,
            "date": "2025-01-08"
          }
        }
      },
      "ing004_gula": {
        "ingredientName": "Gula",
        "currentStock": 1320.0,
        "unit": "gram",
        "dailyConsumption": 118.5,
        "minThreshold": 300,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 11 days",
        "supplier": {
          "name": "Gulaku Distributor",
          "contact": "+62845678901",
          "email": "order@gulaku.co.id"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "G45678": {
            "consumption": 120.0,
            "date": "2025-01-01"
          },
          "G45679": {
            "consumption": 118.7,
            "date": "2025-01-02"
          },
          "G45680": {
            "consumption": 119.3,
            "date": "2025-01-03"
          },
          "G45681": {
            "consumption": 117.2,
            "date": "2025-01-04"
          },
          "G45682": {
            "consumption": 121.1,
            "date": "2025-01-05"
          },
          "G45683": {
            "consumption": 116.8,
            "date": "2025-01-06"
          },
          "G45684": {
            "consumption": 118.9,
            "date": "2025-01-07"
          },
          "G45685": {
            "consumption": 120.4,
            "date": "2025-01-08"
          }
        }
      },
      "ing005_cokelat": {
        "ingredientName": "Dark Cokelat",
        "currentStock": 275.0,
        "unit": "gram",
        "dailyConsumption": 24.8,
        "minThreshold": 100,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 11 days",
        "supplier": {
          "name": "Chocolate Premium",
          "contact": "+62856789012",
          "email": "sales@chocpremium.com"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "D56789": {
            "consumption": 25.0,
            "date": "2025-01-01"
          },
          "D56790": {
            "consumption": 24.5,
            "date": "2025-01-02"
          },
          "D56791": {
            "consumption": 25.3,
            "date": "2025-01-03"
          },
          "D56792": {
            "consumption": 24.1,
            "date": "2025-01-04"
          },
          "D56793": {
            "consumption": 25.7,
            "date": "2025-01-05"
          },
          "D56794": {
            "consumption": 24.2,
            "date": "2025-01-06"
          },
          "D56795": {
            "consumption": 24.9,
            "date": "2025-01-07"
          },
          "D56796": {
            "consumption": 25.1,
            "date": "2025-01-08"
          }
        }
      },
      "ing006_yogurt": {
        "ingredientName": "Yogurt",
        "currentStock": 920.0,
        "unit": "gram",
        "dailyConsumption": 78.3,
        "minThreshold": 250,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 12 days",
        "supplier": {
          "name": "Heavenly Blush",
          "contact": "+62867890123",
          "email": "order@heavenlyblush.com"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "Y67890": {
            "consumption": 80.0,
            "date": "2025-01-01"
          },
          "Y67891": {
            "consumption": 78.5,
            "date": "2025-01-02"
          },
          "Y67892": {
            "consumption": 79.2,
            "date": "2025-01-03"
          },
          "Y67893": {
            "consumption": 77.8,
            "date": "2025-01-04"
          },
          "Y67894": {
            "consumption": 80.1,
            "date": "2025-01-05"
          },
          "Y67895": {
            "consumption": 76.9,
            "date": "2025-01-06"
          },
          "Y67896": {
            "consumption": 78.7,
            "date": "2025-01-07"
          },
          "Y67897": {
            "consumption": 79.3,
            "date": "2025-01-08"
          }
        }
      },
      "ing007_matcha": {
        "ingredientName": "Matcha Bubuk",
        "currentStock": 180.0,
        "unit": "gram",
        "dailyConsumption": 14.2,
        "minThreshold": 50,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 13 days",
        "supplier": {
          "name": "Japanese Tea Import",
          "contact": "+62878901234",
          "email": "info@japanesetea.co.id"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "T78901": {
            "consumption": 15.0,
            "date": "2025-01-01"
          },
          "T78902": {
            "consumption": 14.3,
            "date": "2025-01-02"
          },
          "T78903": {
            "consumption": 14.8,
            "date": "2025-01-03"
          },
          "T78904": {
            "consumption": 13.9,
            "date": "2025-01-04"
          },
          "T78905": {
            "consumption": 15.1,
            "date": "2025-01-05"
          },
          "T78906": {
            "consumption": 13.5,
            "date": "2025-01-06"
          },
          "T78907": {
            "consumption": 14.1,
            "date": "2025-01-07"
          },
          "T78908": {
            "consumption": 14.7,
            "date": "2025-01-08"
          }
        }
      },
      "ing008_earlgrey": {
        "ingredientName": "Earl Grey",
        "currentStock": 135.0,
        "unit": "gram",
        "dailyConsumption": 9.8,
        "minThreshold": 30,
        "status": "sufficient",
        "recommendation": "Stock sufficient for approximately 14 days",
        "supplier": {
          "name": "Premium Tea House",
          "contact": "+62889012345",
          "email": "sales@premiumtea.com"
        },
        "lastUpdated": "2025-01-08T15:30:00.000000",
        "consumptionHistory": {
          "E89012": {
            "consumption": 10.0,
            "date": "2025-01-01"
          },
          "E89013": {
            "consumption": 9.7,
            "date": "2025-01-02"
          },
          "E89014": {
            "consumption": 10.2,
            "date": "2025-01-03"
          },
          "E89015": {
            "consumption": 9.5,
            "date": "2025-01-04"
          },
          "E89016": {
            "consumption": 10.3,
            "date": "2025-01-05"
          },
          "E89017": {
            "consumption": 9.4,
            "date": "2025-01-06"
          },
          "E89018": {
            "consumption": 9.9,
            "date": "2025-01-07"
          },
          "E89019": {
            "consumption": 10.1,
            "date": "2025-01-08"
          }
        }
      }
    },
    "predictions": {
      "pred001_keju": {
        "ingredientId": "ing001_keju",
        "ingredientName": "Keju",
        "unit": "gram",
        "currentStock": 450.5,
        "predictedConsumption": [45.2, 46.1, 44.8, 45.7, 47.3, 44.2, 45.9],
        "predictedStock": [405.3, 359.2, 314.4, 268.7, 221.4, 177.2, 131.3],
        "daysUntilEmpty": 10,
        "recommendedOrder": 500.0,
        "confidence": 0.87,
        "modelParams": {
          "p": 1,
          "d": 1,
          "q": 1,
          "aic": 156.23,
          "bic": 162.45
        },
        "accuracyMetrics": {
          "mae": 2.34,
          "mse": 8.12,
          "rmse": 2.85,
          "mape": 5.2
        },
        "confidenceInterval": {
          "lower": [43.1, 43.8, 42.5, 43.4, 44.9, 41.9, 43.6],
          "upper": [47.3, 48.4, 47.1, 48.0, 49.7, 46.5, 48.2]
        },
        "seasonalComponent": [0.2, -0.1, 0.3, -0.2, 0.4, -0.3, 0.1],
        "trendDirection": "stable",
        "predictionDate": "2025-01-08T15:30:00.000000",
        "nextReorderDate": "2025-01-15T00:00:00.000000",
        "alertLevel": "normal"
      },
      "pred002_susu": {
        "ingredientId": "ing002_susu",
        "ingredientName": "Susu UHT Greenfields",
        "unit": "ml",
        "currentStock": 1850.0,
        "predictedConsumption": [152.3, 154.1, 150.8, 153.2, 156.7, 149.5, 152.9],
        "predictedStock": [1697.7, 1543.6, 1392.8, 1239.6, 1082.9, 933.4, 780.5],
        "daysUntilEmpty": 12,
        "recommendedOrder": 2000.0,
        "confidence": 0.91,
        "modelParams": {
          "p": 2,
          "d": 1,
          "q": 1,
          "aic": 189.67,
          "bic": 197.23
        },
        "accuracyMetrics": {
          "mae": 3.45,
          "mse": 15.67,
          "rmse": 3.96,
          "mape": 2.3
        },
        "confidenceInterval": {
          "lower": [148.2, 149.8, 146.5, 149.1, 152.3, 145.2, 148.6],
          "upper": [156.4, 158.4, 155.1, 157.3, 161.1, 153.8, 157.2]
        },
        "seasonalComponent": [0.1, 0.3, -0.2, 0.1, 0.5, -0.4, 0.0],
        "trendDirection": "increasing",
        "predictionDate": "2025-01-08T15:30:00.000000",
        "nextReorderDate": "2025-01-17T00:00:00.000000",
        "alertLevel": "normal"
      }
    },
    "menuItems": {
      "menu001": {
        "name": "Muffin",
        "price": 20000,
        "category": "pastry",
        "description": "Delicious chocolate muffin with premium ingredients",
        "ingredients": ["ing001_keju", "ing002_susu", "ing004_gula", "ing005_cokelat"],
        "recipe": {
          "ing001_keju": 5.0,
          "ing002_susu": 15.0,
          "ing004_gula": 12.0,
          "ing005_cokelat": 3.0
        },
        "isActive": true,
        "preparationTime": 25,
        "difficulty": "easy",
        "allergens": ["dairy", "gluten"],
        "nutritionInfo": {
          "calories": 280,
          "protein": 6.2,
          "carbs": 35.1,
          "fat": 12.8,
          "fiber": 2.1
        },
        "imageUrl": "https://example.com/images/muffin.jpg",
        "createdAt": "2025-01-01T00:00:00.000000"
      },
      "menu002": {
        "name": "Mini Muffin",
        "price": 15000,
        "category": "pastry",
        "description": "Small sized muffin perfect for snacking",
        "ingredients": ["ing001_keju", "ing002_susu", "ing004_gula"],
        "recipe": {
          "ing001_keju": 3.0,
          "ing002_susu": 10.0,
          "ing004_gula": 8.0
        },
        "isActive": true,
        "preparationTime": 20,
        "difficulty": "easy",
        "allergens": ["dairy", "gluten"],
        "nutritionInfo": {
          "calories": 180,
          "protein": 4.1,
          "carbs": 22.3,
          "fat": 8.2,
          "fiber": 1.4
        },
        "imageUrl": "https://example.com/images/mini-muffin.jpg",
        "createdAt": "2025-01-01T00:00:00.000000"
      },
      "menu003": {
        "name": "Cheesecake",
        "price": 35000,
        "category": "cake",
        "description": "Creamy cheesecake slice with graham cracker crust",
        "ingredients": ["ing001_keju", "ing002_susu", "ing004_gula", "ing006_yogurt"],
        "recipe": {
          "ing001_keju": 15.0,
          "ing002_susu": 20.0,
          "ing004_gula": 10.0,
          "ing006_yogurt": 12.0
        },
        "isActive": true,
        "preparationTime": 45,
        "difficulty": "medium",
        "allergens": ["dairy", "gluten", "eggs"],
        "nutritionInfo": {
          "calories": 420,
          "protein": 8.7,
          "carbs": 28.5,
          "fat": 31.2,
          "fiber": 1.8
        },
        "imageUrl": "https://example.com/images/cheesecake.jpg",
        "createdAt": "2025-01-01T00:00:00.000000"
      },
      "menu004": {
        "name": "Sable Cookies",
        "price": 25000,
        "category": "cookies",
        "description": "Buttery sable cookies with delicate texture",
        "ingredients": ["ing001_keju", "ing004_gula", "ing003_creamer"],
        "recipe": {
          "ing001_keju": 2.0,
          "ing004_gula": 6.0,
          "ing003_creamer": 4.0
        },
        "isActive": true,
        "preparationTime": 35,
        "difficulty": "medium",
        "allergens": ["dairy", "gluten"],
        "nutritionInfo": {
          "calories": 320,
          "protein": 4.5,
          "carbs": 38.2,
          "fat": 16.8,
          "fiber": 1.2
        },
        "imageUrl": "https://example.com/images/sable-cookies.jpg",
        "createdAt": "2025-01-01T00:00:00.000000"
      },
      "menu005": {
        "name": "Croissant",
        "price": 18000,
        "category": "pastry",
        "description": "Flaky butter croissant with layers of buttery goodness",
        "ingredients": ["ing001_keju", "ing002_susu", "ing003_creamer"],
        "recipe": {
          "ing001_keju": 3.0,
          "ing002_susu": 8.0,
          "ing003_creamer": 5.0
        },
        "isActive": true,
        "preparationTime": 60,
        "difficulty": "hard",
        "allergens": ["dairy", "gluten"],
        "nutritionInfo": {
          "calories": 250,
          "protein": 5.8,
          "carbs": 26.4,
          "fat": 14.2,
          "fiber": 2.3
        },
        "imageUrl": "https://example.com/images/croissant.jpg",
        "createdAt": "2025-01-01T00:00:00.000000"
      }
    },
    "userSessions": {
      "session123ABC": {
        "userId": "mmUafQaIuxMAyCBphal7kZuaRzH2",
        "tokenHash": "hashed_jwt_token_here",
        "expiresAt": "2025-01-15T15:30:00.000000",
        "createdAt": "2025-01-08T15:30:00.000000",
        "deviceInfo": {
          "platform": "android",
          "version": "1.0.0",
          "deviceId": "device123"
        }
      }
    },
    "appSettings": {
      "general": {
        "appName": "PastryStock",
        "version": "1.0.0",
        "maintenanceMode": false,
        "supportEmail": "support@pastrystock.com"
      },
      "business": {
        "shopName": "Sweet Bakery",
        "address": "Jl. Raya No. 123, Jakarta",
        "phone": "+62812345678",
        "operatingHours": {
          "open": "08:00",
          "close": "20:00",
          "timezone": "Asia/Jakarta"
        }
      },
      "notifications": {
        "lowStockThreshold": 0.2,
        "criticalStockThreshold": 0.1,
        "enablePushNotifications": true,
        "enableEmailAlerts": true
      },
      "predictions": {
        "arimaEnabled": true,
        "predictionDays": 7,
        "minimumHistoryDays": 7,
        "confidenceThreshold": 0.8
      }
    },
    "analytics": {
      "dailyStats": {
        "2025-01-08": {
          "totalSales": 585000,
          "totalTransactions": 5,
          "totalItemsSold": 40,
          "averageTransactionValue": 117000,
          "topSellingItem": "Mini Muffin",
          "peakHour": "14:00"
        },
        "2025-01-07": {
          "totalSales": 465000,
          "totalTransactions": 4,
          "totalItemsSold": 25,
          "averageTransactionValue": 116250,
          "topSellingItem": "Sable Cookies",
          "peakHour": "16:00"
        }
      },
      "monthlyStats": {
        "2025-01": {
          "totalSales": 1050000,
          "totalTransactions": 9,
          "totalItemsSold": 65,
          "averageTransactionValue": 116667,
          "growthRate": 15.2,
          "topSellingItems": ["Mini Muffin", "Sable Cookies", "Muffin"]
        }
      }
    }
  }
}
[V0_FILE]shellscript:file="api_examples/curl_examples.sh" type="code" isMerged="true"
#!/bin/bash

# PastryStock API - CURL Examples
# Base URL for local development
BASE_URL="http://localhost:5000/api"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== PastryStock API CURL Examples ===${NC}"
echo ""

# Function to print section headers
print_section() {
    echo -e "${YELLOW}$1${NC}"
    echo "----------------------------------------"
}

# Function to execute curl with pretty output
execute_curl() {
    echo -e "${GREEN}Request:${NC} $1"
    echo ""
    eval $1
    echo ""
    echo "----------------------------------------"
    echo ""
}

# 1. AUTHENTICATION ENDPOINTS
print_section "1. AUTHENTICATION ENDPOINTS"

# Login
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/login \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "email": "demo@pastrystock.com",
    "password": "password123"
  }'"'"' \
  | jq .'

# Signup
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/signup \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "New User",
    "email": "newuser@example.com",
    "password": "newpassword123",
    "role": "user"
  }'"'"' \
  | jq .'

# Reset Password
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/reset-password \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "email": "demo@pastrystock.com"
  }'"'"' \
  | jq .'

# 2. USER MANAGEMENT
print_section "2. USER MANAGEMENT"

# Get User Profile (requires authentication)
# Note: Replace JWT_TOKEN with actual token from login response
JWT_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.example.token"

execute_curl 'curl -X GET \
  '"$BASE_URL"'/users/profile \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Update User Profile
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/users/profile \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "Updated Name",
    "email": "updated@example.com"
  }'"'"' \
  | jq .'

# 3. SALES ENDPOINTS
print_section "3. SALES ENDPOINTS"

# Get Recent Sales
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/recent \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Today Sales
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/today \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add New Sale
execute_curl 'curl -X POST \
  '"$BASE_URL"'/sales \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "menuName": "Muffin",
    "quantity": 5,
    "pricePerItem": 20000,
    "metadata": {
      "paymentMethod": "cash",
      "customerName": "Walk-in Customer",
      "notes": "Regular order"
    }
  }'"'"' \
  | jq .'

# Get Sales by Date Range
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales?startDate=2025-01-01&endDate=2025-01-08 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Sales Analytics
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/analytics?period=weekly \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 4. INVENTORY ENDPOINTS
print_section "4. INVENTORY ENDPOINTS"

# Get All Ingredients
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Low Stock Ingredients
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients/low-stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Specific Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients/ing001_keju \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Update Ingredient Stock
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/ingredients/ing001_keju/stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "currentStock": 200,
    "operation": "add",
    "notes": "New stock delivery"
  }'"'"' \
  | jq .'

# Add New Ingredient
execute_curl 'curl -X POST \
  '"$BASE_URL"'/ingredients \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientName": "Vanilla Extract",
    "currentStock": 500,
    "unit": "ml",
    "minThreshold": 100,
    "dailyConsumption": 25,
    "supplier": {
      "name": "Vanilla Supplier",
      "contact": "+62812345678",
      "email": "supplier@vanilla.com"
    }
  }'"'"' \
  | jq .'

# Update Ingredient Details
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/ingredients/ing001_keju \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "minThreshold": 150,
    "supplier": {
      "name": "New Cheese Supplier",
      "contact": "+62823456789",
      "email": "newcheese@supplier.com"
    }
  }'"'"' \
  | jq .'

# 5. PREDICTION ENDPOINTS
print_section "5. PREDICTION ENDPOINTS"

# Get All Predictions
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get ARIMA Prediction for Specific Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/ing001_keju/arima \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Prediction History
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/ing001_keju/history \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Generate New Prediction
execute_curl 'curl -X POST \
  '"$BASE_URL"'/predictions/generate \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientId": "ing001_keju",
    "predictionDays": 7,
    "modelType": "arima"
  }'"'"' \
  | jq .'

# Get Prediction Accuracy
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/accuracy?ingredientId=ing001_keju&days=30 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 6. MENU ITEMS ENDPOINTS
print_section "6. MENU ITEMS ENDPOINTS"

# Get All Menu Items
execute_curl 'curl -X GET \
  '"$BASE_URL"'/menu-items \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Specific Menu Item
execute_curl 'curl -X GET \
  '"$BASE_URL"'/menu-items/menu001 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add New Menu Item
execute_curl 'curl -X POST \
  '"$BASE_URL"'/menu-items \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "Chocolate Eclair",
    "price": 28000,
    "category": "pastry",
    "description": "French pastry filled with cream and topped with chocolate",
    "ingredients": ["ing001_keju", "ing002_susu", "ing005_cokelat"],
    "recipe": {
      "ing001_keju": 8.0,
      "ing002_susu": 25.0,
      "ing005_cokelat": 5.0
    },
    "preparationTime": 40,
    "difficulty": "medium",
    "allergens": ["dairy", "gluten", "eggs"]
  }'"'"' \
  | jq .'

# Update Menu Item
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/menu-items/menu001 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "price": 22000,
    "description": "Updated delicious chocolate muffin with premium ingredients"
  }'"'"' \
  | jq .'

# 7. ANALYTICS ENDPOINTS
print_section "7. ANALYTICS ENDPOINTS"

# Get Dashboard Analytics
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/dashboard \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Sales Trends
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/sales-trends?period=monthly \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Inventory Turnover
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/inventory-turnover \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Popular Items
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/popular-items?limit=5 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 8. CONSUMPTION HISTORY ENDPOINTS
print_section "8. CONSUMPTION HISTORY ENDPOINTS"

# Get Consumption History for Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/consumption-history/ing001_keju?days=30 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add Consumption Record
execute_curl 'curl -X POST \
  '"$BASE_URL"'/consumption-history \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientId": "ing001_keju",
    "date": "2025-01-08",
    "consumption": 45.5,
    "notes": "Manual consumption entry"
  }'"'"' \
  | jq .'

# Update Consumption Record
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/consumption-history/M12352 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "consumption": 47.0,
    "notes": "Corrected consumption value"
  }'"'"' \
  | jq .'

# 9. HEALTH CHECK ENDPOINTS
print_section "9. HEALTH CHECK ENDPOINTS"

# Ping Server
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ping \
  -H "Content-Type: application/json" \
  | jq .'

# Get Server Status
execute_curl 'curl -X GET \
  '"$BASE_URL"'/status \
  -H "Content-Type: application/json" \
  | jq .'

# Get API Version
execute_curl 'curl -X GET \
  '"$BASE_URL"'/version \
  -H "Content-Type: application/json" \
  | jq .'

# 10. BATCH OPERATIONS
print_section "10. BATCH OPERATIONS"

# Batch Update Stock
execute_curl 'curl -X POST \
  '"$BASE_URL"'/ingredients/batch-update-stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "updates": [
      {
        "ingredientId": "ing001_keju",
        "currentStock": 500,
        "operation": "set"
      },
      {
        "ingredientId": "ing002_susu",
        "currentStock": 100,
        "operation": "add"
      }
    ]
  }'"'"' \
  | jq .'

# Batch Add Sales
execute_curl 'curl -X POST \
  '"$BASE_URL"'/sales/batch \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "sales": [
      {
        "menuName": "Muffin",
        "quantity": 3,
        "pricePerItem": 20000
      },
      {
        "menuName": "Croissant",
        "quantity": 2,
        "pricePerItem": 18000
      }
    ]
  }'"'"' \
  | jq .'

# 11. EXPORT/IMPORT ENDPOINTS
print_section "11. EXPORT/IMPORT ENDPOINTS"

# Export Sales Data
execute_curl 'curl -X GET \
  '"$BASE_URL"'/export/sales?format=csv&startDate=2025-01-01&endDate=2025-01-08 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Accept: text/csv"'

# Export Inventory Data
execute_curl 'curl -X GET \
  '"$BASE_URL"'/export/inventory?format=json \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Import Demo Data
execute_curl 'curl -X POST \
  '"$BASE_URL"'/import/demo-data \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

echo -e "${GREEN}=== All API Examples Completed ===${NC}"
echo ""
echo -e "${BLUE}Notes:${NC}"
echo "1. Replace JWT_TOKEN with actual token from login response"
echo "2. Ensure backend server is running on localhost:5000"
echo "3. Install jq for JSON formatting: sudo apt-get install jq"
echo "4. Some endpoints require admin privileges"
echo "5. Check API documentation for complete parameter list"
echo ""
echo -e "${YELLOW}Common HTTP Status Codes:${NC}"
echo "200 - Success"
echo "201 - Created"
echo "400 - Bad Request"
echo "401 - Unauthorized"
echo "403 - Forbidden"
echo "404 - Not Found"
echo "500 - Internal Server Error"
echo ""
echo -e "${GREEN}Happy Testing! 🚀${NC}"
[V0_FILE]shellscript:file="api_examples/postman_collection.json" type="code" isMerged="true"
{
  "info": {
    "name": "PastryStock API",
    "description": "Complete API collection for PastryStock backend",
    "version": "1.0.0",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "auth": {
    "type": "bearer",
    "bearer": [
      {
        "key": "token",
        "value": "{{jwt_token}}",
        "type": "string"
      }
    ]
  },
  "variable": [
    {
      "key": "base_url",
      "value": "http://localhost:5000/api",
      "type": "string"
    },
    {
      "key": "jwt_token",
      "value": "",
      "type": "string"
    }
  ],
  "item": [
    {
      "name": "Authentication",
      "item": [
        {
          "name": "Login",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"email\": \"demo@pastrystock.com\",\n  \"password\": \"password123\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/auth/login",
              "host": ["{{base_url}}"],
              "path": ["auth", "login"]
            }
          },
          "response": []
        },
        {
          "name": "Signup",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"name\": \"New User\",\n  \"email\": \"newuser@example.com\",\n  \"password\": \"newpassword123\",\n  \"role\": \"user\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/auth/signup",
              "host": ["{{base_url}}"],
              "path": ["auth", "signup"]
            }
          },
          "response": []
        },
        {
          "name": "Reset Password",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"email\": \"demo@pastrystock.com\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/auth/reset-password",
              "host": ["{{base_url}}"],
              "path": ["auth", "reset-password"]
            }
          },
          "response": []
        }
      ]
    },
    {
      "name": "Sales",
      "item": [
        {
          "name": "Get Recent Sales",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/sales/recent",
              "host": ["{{base_url}}"],
              "path": ["sales", "recent"]
            }
          },
          "response": []
        },
        {
          "name": "Get Today Sales",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/sales/today",
              "host": ["{{base_url}}"],
              "path": ["sales", "today"]
            }
          },
          "response": []
        },
        {
          "name": "Add Sale",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"menuName\": \"Muffin\",\n  \"quantity\": 5,\n  \"pricePerItem\": 20000,\n  \"metadata\": {\n    \"paymentMethod\": \"cash\",\n    \"customerName\": \"Walk-in Customer\",\n    \"notes\": \"Regular order\"\n  }\n}"
            },
            "url": {
              "raw": "{{base_url}}/sales",
              "host": ["{{base_url}}"],
              "path": ["sales"]
            }
          },
          "response": []
        }
      ]
    },
    {
      "name": "Ingredients",
      "item": [
        {
          "name": "Get All Ingredients",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/ingredients",
              "host": ["{{base_url}}"],
              "path": ["ingredients"]
            }
          },
          "response": []
        },
        {
          "name": "Get Low Stock Ingredients",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/ingredients/low-stock",
              "host": ["{{base_url}}"],
              "path": ["ingredients", "low-stock"]
            }
          },
          "response": []
        },
        {
          "name": "Update Ingredient Stock",
          "request": {
            "method": "PUT",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"currentStock\": 200,\n  \"operation\": \"add\",\n  \"notes\": \"New stock delivery\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/ingredients/ing001_keju/stock",
              "host": ["{{base_url}}"],
              "path": ["ingredients", "ing001_keju", "stock"]
            }
          },
          "response": []
        }
      ]
    },
    {
      "name": "Predictions",
      "item": [
        {
          "name": "Get All Predictions",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/predictions",
              "host": ["{{base_url}}"],
              "path": ["predictions"]
            }
          },
          "response": []
        },
        {
          "name": "Get ARIMA Prediction",
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{base_url}}/predictions/ing001_keju/arima",
              "host": ["{{base_url}}"],
              "path": ["predictions", "ing001_keju", "arima"]
            }
          },
          "response": []
        }
      ]
    }
  ]
}
[V0_FILE]plaintext:file=".env_example" type="code" isMerged="true"
# ===========================================
# PASTRYSTOCK BACKEND CONFIGURATION
# ===========================================

# Firebase Configuration
# Path to your Firebase service account credentials JSON file
# Download from Firebase Console > Project Settings > Service Accounts
FIREBASE_CREDENTIALS=C:\Users\DELL\Documents\pastryztockk\pastrystock\pastrystock\backend/firebase-credentials.json

# Firebase Realtime Database URL
# Get this from Firebase Console > Realtime Database
FIREBASE_DATABASE_URL=https://aplikasi-dashboard-default-rtdb.asia-southeast1.firebasedatabase.app/

# Google Gemini AI API Key
# Get your API key from: https://makersuite.google.com/app/apikey
GEMINI_API_KEY=your_gemini_api_key_here

# Flask Configuration
# Set to TRUE for development, FALSE for production
FLASK_DEBUG=TRUE

# Server Port Configuration
# Default port for Flask development server
PORT=5000

# ===========================================
# ADDITIONAL CONFIGURATION OPTIONS
# ===========================================

# JWT Secret Key (for authentication)
# Generate a secure random string for production
JWT_SECRET_KEY=your_super_secret_jwt_key_here

# Flask Secret Key (for sessions)
# Generate a secure random string for production
SECRET_KEY=your_flask_secret_key_here

# Database Configuration (if using SQL instead of Firebase)
# DATABASE_URL=sqlite:///pastrystock.db
# DATABASE_URL=mysql://username:password@localhost/pastrystock
# DATABASE_URL=postgresql://username:password@localhost/pastrystock

# CORS Configuration
# Comma-separated list of allowed origins
CORS_ORIGINS=http://localhost:3000,http://localhost:8080,http://127.0.0.1:3000

# Email Configuration (for password reset)
# SMTP_SERVER=smtp.gmail.com
# SMTP_PORT=587
# SMTP_USERNAME=your_email@gmail.com
# SMTP_PASSWORD=your_app_password
# SMTP_USE_TLS=True

# Redis Configuration (for caching)
# REDIS_URL=redis://localhost:6379/0

# File Upload Configuration
# MAX_CONTENT_LENGTH=16777216  # 16MB
# UPLOAD_FOLDER=uploads/

# Logging Configuration
# LOG_LEVEL=INFO
# LOG_FILE=logs/pastrystock.log

# API Rate Limiting
# RATELIMIT_STORAGE_URL=redis://localhost:6379
# RATELIMIT_DEFAULT=100 per hour

# Backup Configuration
# BACKUP_ENABLED=True
# BACKUP_INTERVAL=24  # hours
# BACKUP_RETENTION=30  # days

# ===========================================
# SCHEDULE ASSISTANT CONFIGURATION
# ===========================================

# Google Gemini AI API Key (shared with PastryStock)
# GEMINI_API_KEY=your_gemini_api_key_here

# Schedule Assistant Flask Configuration
# SCHEDULE_FLASK_DEBUG=True
# SCHEDULE_PORT=5001

# ===========================================
# PILATES MEMBER CONFIGURATION
# ===========================================

# Pilates Backend Configuration (if applicable)
# PILATES_API_URL=http://localhost:5002
# PILATES_SECRET_KEY=your_pilates_secret_key

# WhatsApp Business API (for payment integration)
# WHATSAPP_API_TOKEN=your_whatsapp_business_token
# WHATSAPP_PHONE_NUMBER_ID=your_phone_number_id

# ===========================================
# DEVELOPMENT ENVIRONMENT SETTINGS
# ===========================================

# Environment Type
ENVIRONMENT=development

# Debug Mode for all applications
DEBUG_MODE=True

# API Timeout Settings (in seconds)
API_TIMEOUT=30

# Default Language
DEFAULT_LANGUAGE=id

# Timezone
TIMEZONE=Asia/Jakarta

# ===========================================
# PRODUCTION ENVIRONMENT SETTINGS
# ===========================================
# Uncomment and configure for production deployment

# SSL Configuration
# SSL_CERT_PATH=/path/to/ssl/cert.pem
# SSL_KEY_PATH=/path/to/ssl/key.pem

# Security Headers
# SECURE_HEADERS=True

# Database Connection Pool
# DB_POOL_SIZE=10
# DB_POOL_TIMEOUT=30

# Monitoring and Analytics
# SENTRY_DSN=your_sentry_dsn_here
# GOOGLE_ANALYTICS_ID=your_ga_id_here

# CDN Configuration
# CDN_URL=https://your-cdn-domain.com

# ===========================================
# DOCKER CONFIGURATION
# ===========================================

# Docker Compose Environment
# COMPOSE_PROJECT_NAME=pastrystock
# COMPOSE_FILE=docker-compose.yml

# Container Configuration
# CONTAINER_PORT=5000
# CONTAINER_NAME=pastrystock-backend

# ===========================================
# INSTRUCTIONS
# ===========================================

# 1. Copy this file to .env in your project root
# 2. Replace all placeholder values with your actual configuration
# 3. Never commit the .env file to version control
# 4. Keep your API keys and secrets secure
# 5. Use different values for development and production environments

# For Firebase setup:
# 1. Go to Firebase Console (https://console.firebase.google.com/)
# 2. Create a new project or select existing
# 3. Go to Project Settings > Service Accounts
# 4. Generate new private key and download JSON file
# 5. Update FIREBASE_CREDENTIALS path to point to downloaded file
# 6. Go to Realtime Database and copy the database URL

# For Gemini AI setup:
# 1. Go to Google AI Studio (https://makersuite.google.com/)
# 2. Create API key
# 3. Replace GEMINI_API_KEY with your actual key

# Security Notes:
# - Use strong, unique passwords and keys
# - Enable 2FA on all accounts
# - Regularly rotate API keys
# - Use environment-specific configurations
# - Monitor API usage and costs
[V0_FILE]markdown:file=".env.example" type="markdown" isMerged="true"
# ===========================================
# FLUTTER PROJECT CONFIGURATION
# Ficram Manifur Farissa
# ===========================================

# ===========================================
# ASISTANT PENJADWALAN CONFIGURATION
# ===========================================

# Flask Configuration
SCHEDULE_FLASK_ENV=development
SCHEDULE_SECRET_KEY=your-super-secret-key-for-schedule-app
SCHEDULE_JWT_SECRET_KEY=your-jwt-secret-key-here
SCHEDULE_PORT=5000

# Database Configuration
SCHEDULE_DATABASE_URL=sqlite:///schedule_app.db
# For PostgreSQL: postgresql://username:password@localhost/schedule_db
# For MySQL: mysql://username:password@localhost/schedule_db

# API Configuration
SCHEDULE_API_BASE_URL=http://localhost:5000
SCHEDULE_API_TIMEOUT=30

# Email Configuration (for notifications)
SCHEDULE_SMTP_SERVER=smtp.gmail.com
SCHEDULE_SMTP_PORT=587
SCHEDULE_SMTP_USERNAME=your-email@gmail.com
SCHEDULE_SMTP_PASSWORD=your-app-password
SCHEDULE_SMTP_USE_TLS=True

# ===========================================
# PILATES MEMBER CONFIGURATION
# ===========================================

# Flask Configuration
PILATES_FLASK_ENV=development
PILATES_SECRET_KEY=your-super-secret-key-for-pilates-app
PILATES_JWT_SECRET_KEY=your-jwt-secret-key-here
PILATES_PORT=5001

# Firebase Configuration
FIREBASE_PROJECT_ID=your-firebase-project-id
FIREBASE_PRIVATE_KEY_ID=your-private-key-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour-Private-Key-Here\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=your-service-account@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your-client-id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_DATABASE_URL=https://your-project-default-rtdb.firebaseio.com/

# Firebase Admin SDK JSON Path
FIREBASE_CREDENTIALS_PATH=./firebase-adminsdk.json

# API Configuration
PILATES_API_BASE_URL=http://localhost:5001
PILATES_API_TIMEOUT=30

# Payment Gateway Configuration (Optional)
PAYMENT_GATEWAY_API_KEY=your-payment-gateway-api-key
PAYMENT_GATEWAY_SECRET=your-payment-gateway-secret
PAYMENT_GATEWAY_WEBHOOK_SECRET=your-webhook-secret

# ===========================================
# SHARED CONFIGURATION
# ===========================================

# Environment
ENVIRONMENT=development
DEBUG_MODE=True

# Security
BCRYPT_LOG_ROUNDS=12
SESSION_TIMEOUT=3600  # 1 hour in seconds

# CORS Configuration
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000,http://10.0.2.2:5000

# Rate Limiting
RATE_LIMIT_PER_MINUTE=60
RATE_LIMIT_PER_HOUR=1000

# Logging Configuration
LOG_LEVEL=INFO
LOG_FILE=logs/app.log
LOG_MAX_BYTES=10485760  # 10MB
LOG_BACKUP_COUNT=5

# File Upload Configuration
MAX_CONTENT_LENGTH=16777216  # 16MB
UPLOAD_FOLDER=uploads/
ALLOWED_EXTENSIONS=png,jpg,jpeg,gif,pdf,doc,docx

# ===========================================
# FLUTTER CONFIGURATION
# ===========================================

# API Endpoints for Flutter Apps
FLUTTER_SCHEDULE_API_URL=http://10.0.2.2:5000  # For Android Emulator
FLUTTER_PILATES_API_URL=http://10.0.2.2:5001   # For Android Emulator

# For iOS Simulator, use:
# FLUTTER_SCHEDULE_API_URL=http://localhost:5000
# FLUTTER_PILATES_API_URL=http://localhost:5001

# For Physical Device, use your computer's IP:
# FLUTTER_SCHEDULE_API_URL=http://192.168.1.100:5000
# FLUTTER_PILATES_API_URL=http://192.168.1.100:5001

# App Configuration
APP_NAME=Flutter Project
APP_VERSION=1.0.0
APP_BUILD_NUMBER=1

# Theme Configuration
DEFAULT_THEME=light  # light, dark, system
PRIMARY_COLOR=0xFF2196F3
ACCENT_COLOR=0xFF03DAC6

# ===========================================
# DEVELOPMENT TOOLS CONFIGURATION
# ===========================================

# Database Tools
DB_ADMIN_USERNAME=admin
DB_ADMIN_PASSWORD=your-db-admin-password

# Testing Configuration
TEST_DATABASE_URL=sqlite:///test.db
TEST_FIREBASE_PROJECT_ID=your-test-project-id

# Docker Configuration
DOCKER_COMPOSE_PROJECT_NAME=flutter-project
CONTAINER_SCHEDULE_PORT=5000
CONTAINER_PILATES_PORT=5001

# ===========================================
# PRODUCTION CONFIGURATION
# ===========================================
# Uncomment and configure for production deployment

# SSL Configuration
# SSL_CERT_PATH=/path/to/ssl/cert.pem
# SSL_KEY_PATH=/path/to/ssl/key.pem
# SSL_ENABLED=True

# Production Database
# PROD_DATABASE_URL=postgresql://username:password@prod-server/database
# PROD_FIREBASE_PROJECT_ID=your-prod-project-id

# Monitoring and Analytics
# SENTRY_DSN=your-sentry-dsn-here
# GOOGLE_ANALYTICS_ID=your-ga-id-here
# MIXPANEL_TOKEN=your-mixpanel-token

# CDN Configuration
# CDN_URL=https://your-cdn-domain.com
# STATIC_URL=https://your-static-domain.com

# Cache Configuration
# REDIS_URL=redis://localhost:6379/0
# MEMCACHED_SERVERS=localhost:11211

# ===========================================
# INSTRUCTIONS
# ===========================================

# 1. Copy this file to .env in your project root
# 2. Replace all placeholder values with your actual configuration
# 3. Never commit the .env file to version control
# 4. Add .env to your .gitignore file
# 5. Use different values for development and production environments

# For Firebase setup:
# 1. Go to Firebase Console (https://console.firebase.google.com/)
# 2. Create a new project
# 3. Go to Project Settings > Service Accounts
# 4. Generate new private key and download JSON file
# 5. Place the JSON file in your project root as firebase-adminsdk.json
# 6. Update the Firebase configuration variables above

# For Flutter development:
# 1. Use 10.0.2.2 for Android Emulator
# 2. Use localhost for iOS Simulator
# 3. Use your computer's IP address for physical devices
# 4. Make sure your backend is running before testing Flutter app

# Security Notes:
# - Use strong, unique passwords and keys
# - Enable 2FA on all accounts
# - Regularly rotate API keys and secrets
# - Use environment-specific configurations
# - Monitor API usage and costs
# - Keep your dependencies updated
[V0_FILE]markdown:file="docs/API_DOCUMENTATION.md" type="markdown" isMerged="true"
# 📡 API Documentation

## Asistant Penjadwalan API

### Authentication Endpoints

#### POST /api/auth/register
Register a new user.

**Request:**
```json
{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "securepassword123",
  "full_name": "John Doe"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user_id": "12345",
    "username": "john_doe",
    "email": "john@example.com",
    "full_name": "John Doe"
  }
}
```

#### POST /api/auth/login
Login user.

**Request:**
```json
{
  "email": "john@example.com",
  "password": "securepassword123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "user_id": "12345",
      "username": "john_doe",
      "email": "john@example.com",
      "full_name": "John Doe"
    }
  }
}
```

### Schedule Endpoints

#### GET /api/schedules
Get all schedules for authenticated user.

**Headers:**
```
Authorization: Bearer <access_token>
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "1",
      "title": "Meeting with Team",
      "description": "Weekly team meeting",
      "date": "2025-01-20",
      "time": "10:00",
      "created_at": "2025-01-15T08:30:00Z"
    }
  ]
}
```

#### POST /api/schedules
Create new schedule.

**Headers:**
```
Authorization: Bearer <access_token>
```

**Request:**
```json
{
  "title": "Doctor Appointment",
  "description": "Annual checkup",
  "date": "2025-01-25",
  "time": "14:30"
}
```

## Pilates Member API

### Member Endpoints

#### GET /api/members/profile
Get member profile.

**Headers:**
```
Authorization: Bearer <firebase_token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "member_id": "abc123",
    "name": "Jane Smith",
    "email": "jane@example.com",
    "membership_type": "premium",
    "membership_expiry": "2025-12-31",
    "classes_remaining": 10
  }
}
```

#### GET /api/classes
Get available Pilates classes.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "class_id": "class_001",
      "name": "Beginner Pilates",
      "instructor": "Sarah Johnson",
      "date": "2025-01-22",
      "time": "09:00",
      "duration": 60,
      "capacity": 15,
      "booked": 8
    }
  ]
}
```
