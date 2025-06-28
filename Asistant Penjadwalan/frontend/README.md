# Schedule Assistant App 🗓️🤖

A Flutter-based mobile application with Flask backend for intelligent schedule management, featuring **Gemini AI** integration for smart scheduling assistance.

---

## 🌟 Features

### 🔧 Core Functionality
- **Smart Schedule Management**: Create, view, and manage daily schedules.
- **AI-Powered Assistant**: Gemini AI integration for intelligent scheduling help.
- **Today's View**: Quick access to today's schedule with Indonesian day names.
- **Batch Operations**: Add multiple schedules at once.

### 💡 User Experience
- **Secure Authentication**: User registration and login system.
- **Intuitive Chat Interface**: Natural language interaction with schedule data.
- **Responsive Design**: Works on all mobile devices.
- **Localized Content**: Indonesian day names and localized responses.

### 🧠 Technical Highlights
- **Flask Backend**: Robust Python backend with REST API.
- **Gemini AI Integration**: Multiple model fallback system.
- **Comprehensive Error Handling**: Graceful degradation when AI is unavailable.
- **Health Monitoring**: System status checks for all components.

---

## 🛠 Tech Stack

### Frontend
- **Flutter**: Cross-platform mobile framework.
- **Dart**: Programming language.
- **Material Design**: UI components.

### Backend
- **Flask**: Python web framework.
- **Google Gemini AI**: Generative AI service.
- **SQLite/MySQL**: Database options.
- **REST API**: Clean API design.

---

## 📋 Prerequisites

Ensure the following are installed:

- [Flutter SDK (≥ 3.0.0)](https://flutter.dev/docs/get-started/install)
- Dart SDK (≥ 3.0.0)
- Python 3.8+
- Google Gemini API key
- Android Studio or VS Code
- Android device/emulator

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/schedule-assistant-app.git
cd schedule-assistant-app
```

### 2. Set up backend

```bash
cd backend
pip install -r requirements.txt
```

### 3. Configure environment

Create a `.env` file with:

```env
GEMINI_API_KEY=your_api_key
FLASK_DEBUG=True
```

### 4. Run backend

```bash
python app.py
```

### 5. Run Flutter app

```bash
flutter pub get
flutter run
```

---

## 📂 Project Structure

```
backend/
├── .env                  # Gemini API, Database Configuration, Flask Configuration
├── app.py                # Main Flask application
├── db_config.py          # Database configuration
├── requirements.txt      # Python dependencies

lib/
├── main.dart             # App entry point
├── pages/                # UI screens
│    ├── home_page.dart
│    ├── splash_screen.dart
│    ├── auth/             # Authentication flows
│    │    ├── forgot_password_page.dart
│    │    ├── signin_page.dart
│    │    └── signup_page.dart
│    ├── chat/             # AI chat interface 
│    │    └── chat_page.dart
│    └── jadwal/           # Schedule management
│         ├── input_jadwal_page.dart
│         ├── jadwal_hari_ini_page.dart
│         └── lihat_jadwal_page.dart
├── services/             # API services
│    ├── auth_service.dart
│    ├── chat_service.dart
│    └── jadwal_service.dart
├── utils/                # Utilities
└── widgets/              # Reusable components
     └── feature_card.dart
```

---

## 🎯 API Endpoints

### 🔐 Authentication
- `POST /signup` - User registration  
- `POST /signin` - User login

### 📆 Schedule Management
- `POST /jadwal` - Add new schedule  
- `GET /jadwal/<user_id>` - Get all schedules  
- `GET /jadwal/hari-ini/<user_id>` - Get today's schedule  
- `DELETE /jadwal/<jadwal_id>` - Delete schedule  
- `POST /jadwal-batch` - Add multiple schedules  

### 🤖 AI Features
- `POST /api/chat` - Chat with AI assistant  
- `GET /api/list-models` - List available AI models  

### 🧪 Utility
- `GET /health` - System health check  

---

## 🔧 Configuration

### Backend
- Set `GEMINI_API_KEY` in `.env`
- Configure database in `db_config.py`
- For emulator access, use: `http://10.0.2.2:5000`

### Frontend
- Update API base URL in `constants.dart`
- Modify theme in `app_theme.dart` (optional)

---

## 🌐 Deployment

### Backend
```bash
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Frontend
```bash
flutter build apk --release
```

---

## 🤝 Contributing

1. Fork the repository  
2. Create your feature branch  
3. Commit your changes  
4. Push to the branch  
5. Open a Pull Request

---

## 📝 License

**MIT License** - see [`LICENSE`](./LICENSE) for details.

---

## 👤 Authors

- **Your Name**

---

## 🙏 Acknowledgments

- **Google** for Gemini AI  
- **Flutter & Flask communities**  
- **Academic advisors**
