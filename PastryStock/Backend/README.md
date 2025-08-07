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
\`\`\`txt
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
\`\`\`

## 🚀 Installation & Setup

### 1. Clone Repository
\`\`\`bash
git clone https://github.com/yourusername/pastrystock-backend.git
cd pastrystock-backend
\`\`\`

### 2. Create Virtual Environment
\`\`\`bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\\Scripts\\activate
# On macOS/Linux:
source venv/bin/activate
\`\`\`

### 3. Install Dependencies
\`\`\`bash
pip install -r requirements.txt
\`\`\`

### 4. Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing
3. Generate service account key:
   - Go to Project Settings > Service Accounts
   - Click "Generate new private key"
   - Save as \`serviceAccountKey.json\` in project root

### 5. Environment Configuration
Create \`.env\` file in project root:
\`\`\`env
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
\`\`\`

### 6. Initialize Database
\`\`\`bash
# Run database initialization script
python init_db.py
\`\`\`

### 7. Start Server
\`\`\`bash
python app.py
\`\`\`

Server will start at \`http://localhost:5000\`

## 📡 API Endpoints

### 🔐 Authentication Endpoints

#### POST /api/auth/login
Login user with email and password.

**Request:**
\`\`\`json
{
  "email": "user@example.com",
  "password": "password123"
}
\`\`\`

**Response:**
\`\`\`json
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
\`\`\`

#### POST /api/auth/signup
Register new user account.

**Request:**
\`\`\`json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "role": "user"
}
\`\`\`

#### POST /api/auth/reset-password
Send password reset email.

**Request:**
\`\`\`json
{
  "email": "user@example.com"
}
\`\`\`

### 👤 User Management

#### GET /api/users/profile
Get current user profile (requires authentication).

**Headers:**
\`\`\`
Authorization: Bearer <jwt_token>
\`\`\`

#### PUT /api/users/profile
Update user profile (requires authentication).

**Request:**
\`\`\`json
{
  "name": "Updated Name",
  "email": "newemail@example.com"
}
\`\`\`

### 💰 Sales Endpoints

#### GET /api/sales/recent
Get 10 most recent sales (requires authentication).

**Response:**
\`\`\`json
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
\`\`\`

#### GET /api/sales/today
Get today's sales summary.

#### POST /api/sales
Add new sale record.

**Request:**
\`\`\`json
{
  "menuName": "Croissant",
  "quantity": 5,
  "pricePerItem": 35000
}
\`\`\`

### 📦 Inventory Endpoints

#### GET /api/ingredients
Get all ingredients with stock levels.

**Response:**
\`\`\`json
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
\`\`\`

#### GET /api/ingredients/low-stock
Get ingredients with low stock levels.

#### PUT /api/ingredients/{id}/stock
Update ingredient stock level.

**Request:**
\`\`\`json
{
  "currentStock": 200,
  "operation": "add"
}
\`\`\`

#### POST /api/ingredients
Add new ingredient.

**Request:**
\`\`\`json
{
  "ingredientName": "Vanilla Extract",
  "currentStock": 500,
  "unit": "ml",
  "minThreshold": 100,
  "dailyConsumption": 25
}
\`\`\`

### 🔮 Prediction Endpoints

#### GET /api/predictions
Generate stock predictions for all ingredients.

**Response:**
\`\`\`json
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
\`\`\`

#### GET /api/predictions/{id}/arima
Get ARIMA-based prediction for specific ingredient.

#### GET /api/predictions/{id}/history
Get prediction history for ingredient.

### 🍰 Menu Endpoints

#### GET /api/menu-items
Get all menu items.

**Response:**
\`\`\`json
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
\`\`\`

### 🏥 Health Check

#### GET /api/ping
Check server status.

#### GET /
Welcome message with ASCII art.

## 🗄️ Database Schema

### Users Collection
\`\`\`json
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
\`\`\`

### Sales Collection
\`\`\`json
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
\`\`\`

### Ingredients Collection
\`\`\`json
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
\`\`\`

## 🔧 Configuration

### Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| \`FIREBASE_CREDENTIALS\` | Path to Firebase service account key | \`serviceAccountKey.json\` |
| \`FIREBASE_DATABASE_URL\` | Firebase Realtime Database URL | \`https://project.firebaseio.com\` |
| \`GEMINI_API_KEY\` | Google Gemini AI API key | \`AIza....\` |
| \`FLASK_DEBUG\` | Enable Flask debug mode | \`TRUE\` |
| \`PORT\` | Server port | \`5000\` |
| \`SECRET_KEY\` | Flask secret key | \`your-secret-key\` |
| \`JWT_SECRET_KEY\` | JWT signing key | \`jwt-secret-key\` |

### Firebase Security Rules
\`\`\`json
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
\`\`\`

## 🧪 Testing

### Run Unit Tests
\`\`\`bash
python -m pytest tests/ -v
\`\`\`

### Run Integration Tests
\`\`\`bash
python -m pytest tests/integration/ -v
\`\`\`

### Test Coverage
\`\`\`bash
python -m pytest --cov=app tests/
\`\`\`

## 📊 Performance Optimization

### Database Optimization
- Use Firebase indexing for frequently queried fields
- Implement pagination for large datasets
- Cache frequently accessed data
- Use batch operations for multiple writes

### API Optimization
\`\`\`python
# Example: Caching with Flask-Caching
from flask_caching import Cache

cache = Cache(app, config={'CACHE_TYPE': 'simple'})

@app.route('/api/ingredients')
@cache.cached(timeout=300)  # Cache for 5 minutes
def get_ingredients():
    return get_all_ingredients()
\`\`\`

### ARIMA Model Optimization
\`\`\`python
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
\`\`\`

## 🔒 Security Best Practices

### Authentication Security
- Use strong JWT secrets
- Implement token expiration
- Hash passwords with bcrypt
- Validate all input data

### API Security
\`\`\`python
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
\`\`\`

### Firebase Security
- Enable Firebase Authentication
- Set up proper security rules
- Use HTTPS only
- Implement rate limiting

## 🚀 Deployment

### Docker Deployment
\`\`\`dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 5000

CMD ["python", "app.py"]
\`\`\`

### Heroku Deployment
\`\`\`bash
# Install Heroku CLI
heroku create pastrystock-backend
heroku config:set FIREBASE_DATABASE_URL=your-url
heroku config:set GEMINI_API_KEY=your-key
git push heroku main
\`\`\`

### Production Environment
\`\`\`bash
# Use production WSGI server
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
\`\`\`

## 🐛 Troubleshooting

### Common Issues

#### Firebase Connection Error
\`\`\`bash
# Check Firebase credentials
export GOOGLE_APPLICATION_CREDENTIALS="serviceAccountKey.json"
python -c "import firebase_admin; print('Firebase OK')"
\`\`\`

#### ARIMA Prediction Errors
\`\`\`python
# Ensure sufficient data points
if len(consumption_data) < 7:
    return {"error": "Insufficient data for ARIMA prediction"}
\`\`\`

#### Memory Issues
\`\`\`bash
# Monitor memory usage
pip install memory-profiler
python -m memory_profiler app.py
\`\`\`

## 📈 Monitoring & Logging

### Application Logging
\`\`\`python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('app.log'),
        logging.StreamHandler()
    ]
)
\`\`\`

### Performance Monitoring
\`\`\`python
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
\`\`\`

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create feature branch: \`git checkout -b feature/amazing-feature\`
3. Make changes and add tests
4. Run tests: \`python -m pytest\`
5. Commit changes: \`git commit -m 'Add amazing feature'\`
6. Push to branch: \`git push origin feature/amazing-feature\`
7. Create Pull Request

### Code Style
- Follow PEP 8 guidelines
- Use type hints where possible
- Add docstrings to functions
- Write unit tests for new features

### Testing Guidelines
\`\`\`python
import unittest
from app import app

class TestAPI(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True
    
    def test_ping_endpoint(self):
        response = self.app.get('/api/ping')
        self.assertEqual(response.status_code, 200)
\`\`\`

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
