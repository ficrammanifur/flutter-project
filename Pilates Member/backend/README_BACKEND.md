# Pilates Membership Backend API

A complete Flask backend API for the Pilates Membership Flutter app with authentication, membership management, and class booking features.

## 🚀 Quick Start

### 1. Install Dependencies
\`\`\`bash
pip install -r requirements.txt
\`\`\`

### 2. Set Environment Variables
\`\`\`bash
# Copy the .env file and modify if needed
cp .env .env.local
\`\`\`

### 3. Initialize Database
\`\`\`bash
python db_config.py
\`\`\`

### 4. Start the Server
\`\`\`bash
python main.py
\`\`\`

The server will start at `http://localhost:5000`

### 5. Test the API
\`\`\`bash
python test_api.py
\`\`\`

## 📱 Frontend Integration

Your Flutter app will automatically connect to this backend. The frontend is configured to:

1. **Try backend first** - Attempts to connect to `http://10.0.2.2:5000` (Android emulator)
2. **Fallback to mock data** - If backend is unavailable, uses offline mock data
3. **Seamless experience** - Users won't notice if backend is down

## 🔧 API Endpoints

### Authentication
- `POST /auth/login` - User login
- `POST /auth/register` - User registration

### User Management
- `GET /user/profile` - Get user profile (requires token)
- `PUT /user/profile` - Update user profile (requires token)

### Packages & Classes
- `GET /packages` - Get membership packages
- `GET /classes/available` - Get available classes

### Bookings
- `GET /bookings/<user_id>` - Get user bookings
- `POST /bookings` - Create new booking
- `DELETE /bookings/<booking_id>` - Cancel booking

### Utility
- `GET /` - Health check

## 🔐 Authentication

The API uses JWT tokens for authentication:

1. **Login/Register** returns a JWT token
2. **Protected endpoints** require `Authorization: Bearer <token>` header
3. **Tokens expire** after 7 days

## 📊 Sample Data

### Demo Users
- **Email**: `afaf@example.com` | **Password**: `password123`
- **Email**: `rei@example.com` | **Password**: `password123`
- **Email**: `admin@pilatesstudio.com` | **Password**: `admin123`

### Membership Packages
- **Basic Package**: 4 classes, $80, 30 days
- **Premium Package**: 8 classes, $140, 30 days
- **Unlimited Package**: Unlimited classes, $200, 30 days
- **Trial Package**: 1 class, $25, 7 days

## 🛠️ Development

### Running in Development Mode
\`\`\`bash
export FLASK_ENV=development
export FLASK_DEBUG=True
python main.py
\`\`\`

### Testing All Endpoints
\`\`\`bash
python test_api.py
\`\`\`

### Adding New Features

1. **Add new routes** in `main.py`
2. **Update database models** in `db_config.py`
3. **Test endpoints** using `test_api.py`

## 🔄 Data Flow

\`\`\`
Flutter App → HTTP Request → Flask API → In-Memory Database → JSON Response → Flutter App
\`\`\`

### Example Login Flow:
1. Flutter sends `POST /auth/login` with email/password
2. Backend validates credentials
3. Backend generates JWT token
4. Backend returns user data + token
5. Flutter stores token for future requests

## 🚀 Production Deployment

### Environment Variables
\`\`\`bash
JWT_SECRET=your-super-secure-secret-key
FLASK_ENV=production
FLASK_DEBUG=False
\`\`\`

### Database Migration
Replace in-memory database with:
- **PostgreSQL** for production
- **SQLite** for development
- **MongoDB** for document storage

### Security Enhancements
- Use HTTPS only
- Implement rate limiting
- Add input validation
- Use secure JWT secrets
- Add CORS restrictions

## 📈 Monitoring

### Health Check
\`\`\`bash
curl http://localhost:5000/
\`\`\`

### API Status
The backend logs all requests and errors to console.

## 🔧 Troubleshooting

### Common Issues

1. **Port 5000 already in use**
   \`\`\`bash
   # Kill process using port 5000
   lsof -ti:5000 | xargs kill -9
   \`\`\`

2. **CORS errors**
   - Backend has CORS enabled for all origins
   - Check if Flask-CORS is installed

3. **JWT token errors**
   - Check if JWT_SECRET is set
   - Verify token format in requests

4. **Connection refused**
   - Ensure backend is running on correct port
   - Check firewall settings

### Debug Mode
\`\`\`bash
export FLASK_DEBUG=True
python main.py
\`\`\`

## 📚 API Documentation

### Request/Response Examples

#### Login
\`\`\`bash
curl -X POST http://localhost:5000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","password":"password123"}'
\`\`\`

#### Get Packages
\`\`\`bash
curl http://localhost:5000/packages
\`\`\`

#### Create Booking
\`\`\`bash
curl -X POST http://localhost:5000/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "1",
    "class_name": "Morning Flow",
    "scheduled_time": "2024-01-15T09:00:00",
    "instructor": "Sarah Johnson"
  }'
\`\`\`

## 🎯 Features

✅ **Complete Authentication System**
✅ **JWT Token Management**
✅ **User Registration & Login**
✅ **Membership Package Management**
✅ **Class Booking System**
✅ **User Profile Management**
✅ **Error Handling & Validation**
✅ **CORS Support**
✅ **Health Check Endpoint**
✅ **Comprehensive Testing**

## 🔮 Future Enhancements

- [ ] Database integration (PostgreSQL/MongoDB)
- [ ] Payment processing (Stripe/PayPal)
- [ ] Email notifications
- [ ] Push notifications
- [ ] Admin dashboard
- [ ] Class scheduling system
- [ ] Instructor management
- [ ] Analytics and reporting

---
**Structure Backend
📁 Backend
├── main.py             # Main server file (Flask)
├── db_config.py        # Setup database in-memory
├── test_api.py         # File untuk testing endpoint
├── .env                # Environment variables (JWT secret, dll)
├── requirements.txt    # Daftar dependencies Python

**🎉 Your backend is ready! The Flutter app will now work with real API calls.**
