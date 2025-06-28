from flask import Flask, request, jsonify
from flask_cors import CORS
import hashlib
import jwt
import datetime
from functools import wraps
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Configuration
app.config['SECRET_KEY'] = os.getenv('JWT_SECRET', 'your-super-secret-jwt-key-here')

# In-memory database (replace with real database in production)
users_db = [
    {
        'id': '1',
        'name': 'John Doe',
        'email': 'john@example.com',
        'password': hashlib.sha256('password123'.encode()).hexdigest(),
        'phone': '+6281234567890',
        'membership_type': 'Premium',
        'remaining_classes': 8,
        'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=30)).isoformat(),
        'is_active': True,
    },
    {
        'id': '2',
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'password': hashlib.sha256('password123'.encode()).hexdigest(),
        'phone': '+6281234567891',
        'membership_type': 'Basic',
        'remaining_classes': 4,
        'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=15)).isoformat(),
        'is_active': True,
    }
]

# Updated packages with IDR pricing
packages_db = [
    {
        'id': '1',
        'name': 'Paket Basic',
        'classes': 4,
        'price': 800000.0,  # 800,000 IDR
        'validity_days': 30,
        'description': '4 kelas per bulan - Sempurna untuk pemula',
    },
    {
        'id': '2',
        'name': 'Paket Premium',
        'classes': 8,
        'price': 1400000.0,  # 1,400,000 IDR
        'validity_days': 30,
        'description': '8 kelas per bulan - Pilihan paling populer',
    },
    {
        'id': '3',
        'name': 'Paket Unlimited',
        'classes': 999,
        'price': 2000000.0,  # 2,000,000 IDR
        'validity_days': 30,
        'description': 'Kelas tak terbatas - Untuk praktisi yang berdedikasi',
    },
    {
        'id': '4',
        'name': 'Paket Trial',
        'classes': 1,
        'price': 250000.0,  # 250,000 IDR
        'validity_days': 7,
        'description': 'Coba satu kelas - Sempurna untuk pemula',
    },
]

bookings_db = [
    {
        'id': '1',
        'user_id': '1',
        'class_name': 'Morning Flow',
        'scheduled_time': (datetime.datetime.now() + datetime.timedelta(days=1, hours=9)).isoformat(),
        'status': 'confirmed',
        'instructor': 'Sarah Johnson',
    },
    {
        'id': '2',
        'user_id': '1',
        'class_name': 'Evening Stretch',
        'scheduled_time': (datetime.datetime.now() + datetime.timedelta(days=2, hours=18)).isoformat(),
        'status': 'confirmed',
        'instructor': 'Mike Chen',
    },
    {
        'id': '3',
        'user_id': '2',
        'class_name': 'Beginner Pilates',
        'scheduled_time': (datetime.datetime.now() + datetime.timedelta(days=1, hours=10)).isoformat(),
        'status': 'confirmed',
        'instructor': 'Lisa Wong',
    },
]

# Helper functions
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

def generate_token(user_id):
    payload = {
        'user_id': user_id,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(days=7)
    }
    return jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')

def verify_token(token):
    try:
        payload = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        return payload['user_id']
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token:
            return jsonify({'success': False, 'message': 'Token is missing'}), 401
        
        if token.startswith('Bearer '):
            token = token[7:]
        
        user_id = verify_token(token)
        if not user_id:
            return jsonify({'success': False, 'message': 'Token is invalid'}), 401
        
        return f(user_id, *args, **kwargs)
    return decorated

def find_user_by_email(email):
    return next((user for user in users_db if user['email'] == email), None)

def find_user_by_id(user_id):
    return next((user for user in users_db if user['id'] == user_id), None)

def user_to_dict(user):
    """Convert user object to dictionary, excluding password"""
    user_dict = user.copy()
    if 'password' in user_dict:
        del user_dict['password']
    return user_dict

def format_idr(amount):
    """Format amount to Indonesian Rupiah"""
    return f"Rp {amount:,.0f}".replace(',', '.')

# Routes
@app.route('/', methods=['GET'])
def health_check():
    return jsonify({
        'success': True,
        'message': 'Pilates Membership API is running!',
        'version': '1.0.0',
        'currency': 'IDR',
        'timestamp': datetime.datetime.now().isoformat()
    })

@app.route('/auth/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        
        if not data or not data.get('email') or not data.get('password'):
            return jsonify({
                'success': False,
                'message': 'Email dan password diperlukan'
            }), 400
        
        email = data['email'].lower().strip()
        password = data['password']
        
        # Find user
        user = find_user_by_email(email)
        if not user:
            return jsonify({
                'success': False,
                'message': 'Email atau password salah'
            }), 401
        
        # Verify password
        if user['password'] != hash_password(password):
            return jsonify({
                'success': False,
                'message': 'Email atau password salah'
            }), 401
        
        # Check if user is active
        if not user.get('is_active', False):
            return jsonify({
                'success': False,
                'message': 'Akun telah dinonaktifkan'
            }), 401
        
        # Generate token
        token = generate_token(user['id'])
        
        return jsonify({
            'success': True,
            'message': 'Login berhasil',
            'user': user_to_dict(user),
            'token': token
        })
        
    except Exception as e:
        print(f"Login error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/auth/register', methods=['POST'])
def register():
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['name', 'email', 'password', 'phone']
        for field in required_fields:
            if not data or not data.get(field):
                field_names = {
                    'name': 'Nama',
                    'email': 'Email',
                    'password': 'Password',
                    'phone': 'Nomor telepon'
                }
                return jsonify({
                    'success': False,
                    'message': f'{field_names[field]} diperlukan'
                }), 400
        
        name = data['name'].strip()
        email = data['email'].lower().strip()
        password = data['password']
        phone = data['phone'].strip()
        
        # Validate email format
        if '@' not in email or '.' not in email:
            return jsonify({
                'success': False,
                'message': 'Format email tidak valid'
            }), 400
        
        # Check if user already exists
        if find_user_by_email(email):
            return jsonify({
                'success': False,
                'message': 'Email sudah terdaftar'
            }), 409
        
        # Validate password length
        if len(password) < 6:
            return jsonify({
                'success': False,
                'message': 'Password minimal 6 karakter'
            }), 400
        
        # Create new user
        new_user = {
            'id': str(len(users_db) + 1),
            'name': name,
            'email': email,
            'password': hash_password(password),
            'phone': phone,
            'membership_type': 'Trial',
            'remaining_classes': 1,
            'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=7)).isoformat(),
            'is_active': True,
        }
        
        users_db.append(new_user)
        
        # Generate token
        token = generate_token(new_user['id'])
        
        return jsonify({
            'success': True,
            'message': 'Registrasi berhasil',
            'user': user_to_dict(new_user),
            'token': token
        }), 201
        
    except Exception as e:
        print(f"Registration error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/packages', methods=['GET'])
def get_packages():
    try:
        # Add formatted price for display
        packages_with_format = []
        for package in packages_db:
            package_copy = package.copy()
            package_copy['formatted_price'] = format_idr(package['price'])
            packages_with_format.append(package_copy)
        
        return jsonify({
            'success': True,
            'packages': packages_with_format
        })
    except Exception as e:
        print(f"Get packages error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/bookings/<user_id>', methods=['GET'])
def get_user_bookings(user_id):
    try:
        # Find user bookings
        user_bookings = [booking for booking in bookings_db if booking['user_id'] == user_id]
        
        return jsonify({
            'success': True,
            'bookings': user_bookings
        })
    except Exception as e:
        print(f"Get bookings error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/bookings', methods=['POST'])
def create_booking():
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['user_id', 'class_name', 'scheduled_time', 'instructor']
        for field in required_fields:
            if not data or not data.get(field):
                return jsonify({
                    'success': False,
                    'message': f'{field} diperlukan'
                }), 400
        
        # Verify user exists
        user = find_user_by_id(data['user_id'])
        if not user:
            return jsonify({
                'success': False,
                'message': 'User tidak ditemukan'
            }), 404
        
        # Check if user has remaining classes
        if user['remaining_classes'] <= 0:
            return jsonify({
                'success': False,
                'message': 'Kelas tersisa habis. Silakan beli paket baru.'
            }), 400
        
        # Create new booking
        new_booking = {
            'id': str(len(bookings_db) + 1),
            'user_id': data['user_id'],
            'class_name': data['class_name'],
            'scheduled_time': data['scheduled_time'],
            'status': 'confirmed',
            'instructor': data['instructor'],
        }
        
        bookings_db.append(new_booking)
        
        # Decrease user's remaining classes
        user['remaining_classes'] -= 1
        
        return jsonify({
            'success': True,
            'message': 'Kelas berhasil dibooking',
            'booking': new_booking
        }), 201
        
    except Exception as e:
        print(f"Create booking error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/bookings/<booking_id>', methods=['DELETE'])
def cancel_booking(booking_id):
    try:
        # Find booking
        booking = next((b for b in bookings_db if b['id'] == booking_id), None)
        if not booking:
            return jsonify({
                'success': False,
                'message': 'Booking tidak ditemukan'
            }), 404
        
        # Update booking status
        booking['status'] = 'cancelled'
        
        # Refund class to user
        user = find_user_by_id(booking['user_id'])
        if user:
            user['remaining_classes'] += 1
        
        return jsonify({
            'success': True,
            'message': 'Booking berhasil dibatalkan',
            'booking': booking
        })
        
    except Exception as e:
        print(f"Cancel booking error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/user/profile', methods=['GET'])
@token_required
def get_user_profile(user_id):
    try:
        user = find_user_by_id(user_id)
        if not user:
            return jsonify({
                'success': False,
                'message': 'User tidak ditemukan'
            }), 404
        
        return jsonify({
            'success': True,
            'user': user_to_dict(user)
        })
        
    except Exception as e:
        print(f"Get profile error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/user/profile', methods=['PUT'])
@token_required
def update_user_profile(user_id):
    try:
        data = request.get_json()
        user = find_user_by_id(user_id)
        
        if not user:
            return jsonify({
                'success': False,
                'message': 'User tidak ditemukan'
            }), 404
        
        # Update allowed fields
        allowed_fields = ['name', 'phone']
        for field in allowed_fields:
            if field in data:
                user[field] = data[field]
        
        return jsonify({
            'success': True,
            'message': 'Profil berhasil diperbarui',
            'user': user_to_dict(user)
        })
        
    except Exception as e:
        print(f"Update profile error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/classes/available', methods=['GET'])
def get_available_classes():
    try:
        # Mock available classes
        available_classes = [
            {
                'id': '1',
                'name': 'Morning Flow',
                'instructor': 'Sarah Johnson',
                'duration': 60,
                'capacity': 12,
                'booked': 8,
                'price_per_class': 'Termasuk dalam paket',
                'schedule': [
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=1)).strftime('%Y-%m-%d'),
                        'time': '09:00'
                    },
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=3)).strftime('%Y-%m-%d'),
                        'time': '09:00'
                    }
                ]
            },
            {
                'id': '2',
                'name': 'Evening Stretch',
                'instructor': 'Mike Chen',
                'duration': 45,
                'capacity': 10,
                'booked': 5,
                'price_per_class': 'Termasuk dalam paket',
                'schedule': [
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=2)).strftime('%Y-%m-%d'),
                        'time': '18:00'
                    },
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=4)).strftime('%Y-%m-%d'),
                        'time': '18:00'
                    }
                ]
            },
            {
                'id': '3',
                'name': 'Beginner Pilates',
                'instructor': 'Lisa Wong',
                'duration': 50,
                'capacity': 8,
                'booked': 3,
                'price_per_class': 'Termasuk dalam paket',
                'schedule': [
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=1)).strftime('%Y-%m-%d'),
                        'time': '10:00'
                    },
                    {
                        'date': (datetime.datetime.now() + datetime.timedelta(days=5)).strftime('%Y-%m-%d'),
                        'time': '10:00'
                    }
                ]
            }
        ]
        
        return jsonify({
            'success': True,
            'classes': available_classes
        })
        
    except Exception as e:
        print(f"Get available classes error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

@app.route('/payment/whatsapp-link', methods=['POST'])
def generate_whatsapp_payment():
    try:
        data = request.get_json()
        
        required_fields = ['package_name', 'amount', 'user_name']
        for field in required_fields:
            if not data or not data.get(field):
                return jsonify({
                    'success': False,
                    'message': f'{field} diperlukan'
                }), 400
        
        package_name = data['package_name']
        amount = data['amount']
        user_name = data['user_name']
        
        # Format amount to IDR
        formatted_amount = format_idr(amount)
        
        # Create WhatsApp message in Indonesian
        message = f'''Halo! Saya ingin membeli {package_name} seharga {formatted_amount}.

Nama: {user_name}
Paket: {package_name}
Harga: {formatted_amount}

Mohon konfirmasi pembayaran saya dan aktifkan membership saya.
Terima kasih!'''
        
        # Indonesian phone number format (replace with actual studio number)
        phone_number = '6281234567890'  # Indonesian format
        
        # Generate WhatsApp URL
        import urllib.parse
        encoded_message = urllib.parse.quote(message)
        whatsapp_url = f'https://wa.me/{phone_number}?text={encoded_message}'
        
        return jsonify({
            'success': True,
            'whatsapp_url': whatsapp_url,
            'message': 'Link WhatsApp berhasil dibuat',
            'formatted_amount': formatted_amount
        })
        
    except Exception as e:
        print(f"Generate WhatsApp payment error: {str(e)}")
        return jsonify({
            'success': False,
            'message': 'Terjadi kesalahan server'
        }), 500

# Error handlers
@app.errorhandler(404)
def not_found(error):
    return jsonify({
        'success': False,
        'message': 'Endpoint tidak ditemukan'
    }), 404

@app.errorhandler(405)
def method_not_allowed(error):
    return jsonify({
        'success': False,
        'message': 'Method tidak diizinkan'
    }), 405

@app.errorhandler(500)
def internal_error(error):
    return jsonify({
        'success': False,
        'message': 'Terjadi kesalahan server'
    }), 500

if __name__ == '__main__':
    print("🚀 Starting Pilates Membership API Server...")
    print("📱 Frontend dapat terhubung ke: http://localhost:5000")
    print("🔧 Health check: http://localhost:5000/")
    print("💰 Currency: Indonesian Rupiah (IDR)")
    print("📚 Available endpoints:")
    print("   POST /auth/login")
    print("   POST /auth/register")
    print("   GET  /packages")
    print("   GET  /bookings/<user_id>")
    print("   POST /bookings")
    print("   GET  /classes/available")
    print("   GET  /user/profile (requires token)")
    print("   PUT  /user/profile (requires token)")
    print("   POST /payment/whatsapp-link")
    
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=os.getenv('FLASK_DEBUG', 'True').lower() == 'true'
    )
