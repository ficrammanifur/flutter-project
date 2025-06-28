"""
Database configuration and initialization script.
This file sets up the initial database structure and sample data.
"""

import datetime
import hashlib

def hash_password(password):
    """Hash password using SHA-256"""
    return hashlib.sha256(password.encode()).hexdigest()

def initialize_database():
    """Initialize database with sample data"""
    
    print("🔧 Initializing Pilates Membership Database...")
    
    # Sample users
    users = [
        {
            'id': '1',
            'name': 'John Doe',
            'email': 'john@example.com',
            'password': hash_password('password123'),
            'phone': '+1234567890',
            'membership_type': 'Premium',
            'remaining_classes': 8,
            'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=30)).isoformat(),
            'is_active': True,
        },
        {
            'id': '2',
            'name': 'Jane Smith',
            'email': 'jane@example.com',
            'password': hash_password('password123'),
            'phone': '+1234567891',
            'membership_type': 'Basic',
            'remaining_classes': 4,
            'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=15)).isoformat(),
            'is_active': True,
        },
        {
            'id': '3',
            'name': 'Admin User',
            'email': 'admin@pilatesstudio.com',
            'password': hash_password('admin123'),
            'phone': '+1234567892',
            'membership_type': 'Admin',
            'remaining_classes': 999,
            'membership_expiry': (datetime.datetime.now() + datetime.timedelta(days=365)).isoformat(),
            'is_active': True,
        }
    ]
    
    # Sample packages
    packages = [
        {
            'id': '1',
            'name': 'Basic Package',
            'classes': 4,
            'price': 80.0,
            'validity_days': 30,
            'description': '4 classes per month - Perfect for beginners',
        },
        {
            'id': '2',
            'name': 'Premium Package',
            'classes': 8,
            'price': 140.0,
            'validity_days': 30,
            'description': '8 classes per month - Most popular choice',
        },
        {
            'id': '3',
            'name': 'Unlimited Package',
            'classes': 999,
            'price': 200.0,
            'validity_days': 30,
            'description': 'Unlimited classes - For dedicated practitioners',
        },
        {
            'id': '4',
            'name': 'Trial Package',
            'classes': 1,
            'price': 25.0,
            'validity_days': 7,
            'description': 'Try one class - Perfect for first-timers',
        }
    ]
    
    # Sample bookings
    bookings = [
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
        }
    ]
    
    print(f"✅ Created {len(users)} sample users")
    print(f"✅ Created {len(packages)} membership packages")
    print(f"✅ Created {len(bookings)} sample bookings")
    
    print("\n📋 Sample User Credentials:")
    print("   Email: john@example.com | Password: password123")
    print("   Email: jane@example.com | Password: password123")
    print("   Email: admin@pilatesstudio.com | Password: admin123")
    
    print("\n🎯 Database initialization completed!")
    
    return {
        'users': users,
        'packages': packages,
        'bookings': bookings
    }

if __name__ == '__main__':
    initialize_database()
