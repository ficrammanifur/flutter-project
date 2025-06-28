"""
API Testing Script
Run this to test all the backend endpoints
"""

import requests
import json

BASE_URL = 'http://localhost:5000'

def test_health_check():
    """Test health check endpoint"""
    print("🔍 Testing health check...")
    try:
        response = requests.get(f'{BASE_URL}/')
        print(f"Status: {response.status_code}")
        print(f"Response: {response.json()}")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ Health check failed: {e}")
        return False

def test_login():
    """Test login endpoint"""
    print("\n🔍 Testing login...")
    try:
        data = {
            'email': 'john@example.com',
            'password': 'password123'
        }
        response = requests.post(f'{BASE_URL}/auth/login', json=data)
        print(f"Status: {response.status_code}")
        result = response.json()
        print(f"Response: {json.dumps(result, indent=2)}")
        
        if result.get('success'):
            return result.get('token')
        return None
    except Exception as e:
        print(f"❌ Login failed: {e}")
        return None

def test_register():
    """Test registration endpoint"""
    print("\n🔍 Testing registration...")
    try:
        data = {
            'name': 'Test User',
            'email': 'test@example.com',
            'password': 'password123',
            'phone': '+1234567893'
        }
        response = requests.post(f'{BASE_URL}/auth/register', json=data)
        print(f"Status: {response.status_code}")
        result = response.json()
        print(f"Response: {json.dumps(result, indent=2)}")
        return response.status_code == 201
    except Exception as e:
        print(f"❌ Registration failed: {e}")
        return False

def test_packages():
    """Test packages endpoint"""
    print("\n🔍 Testing packages...")
    try:
        response = requests.get(f'{BASE_URL}/packages')
        print(f"Status: {response.status_code}")
        result = response.json()
        print(f"Found {len(result.get('packages', []))} packages")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ Packages test failed: {e}")
        return False

def test_bookings():
    """Test bookings endpoint"""
    print("\n🔍 Testing bookings...")
    try:
        # Get user bookings
        response = requests.get(f'{BASE_URL}/bookings/1')
        print(f"Status: {response.status_code}")
        result = response.json()
        print(f"Found {len(result.get('bookings', []))} bookings for user 1")
        
        # Create new booking
        booking_data = {
            'user_id': '1',
            'class_name': 'Test Class',
            'scheduled_time': '2024-01-15T10:00:00',
            'instructor': 'Test Instructor'
        }
        response = requests.post(f'{BASE_URL}/bookings', json=booking_data)
        print(f"Create booking status: {response.status_code}")
        
        return True
    except Exception as e:
        print(f"❌ Bookings test failed: {e}")
        return False

def test_available_classes():
    """Test available classes endpoint"""
    print("\n🔍 Testing available classes...")
    try:
        response = requests.get(f'{BASE_URL}/classes/available')
        print(f"Status: {response.status_code}")
        result = response.json()
        print(f"Found {len(result.get('classes', []))} available classes")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ Available classes test failed: {e}")
        return False

def main():
    """Run all tests"""
    print("🚀 Starting API Tests...\n")
    
    tests = [
        ("Health Check", test_health_check),
        ("Login", test_login),
        ("Register", test_register),
        ("Packages", test_packages),
        ("Bookings", test_bookings),
        ("Available Classes", test_available_classes),
    ]
    
    results = []
    for test_name, test_func in tests:
        try:
            result = test_func()
            results.append((test_name, result))
        except Exception as e:
            print(f"❌ {test_name} test crashed: {e}")
            results.append((test_name, False))
    
    print("\n📊 Test Results:")
    print("=" * 40)
    passed = 0
    for test_name, result in results:
        status = "✅ PASS" if result else "❌ FAIL"
        print(f"{test_name:<20} {status}")
        if result:
            passed += 1
    
    print("=" * 40)
    print(f"Passed: {passed}/{len(results)} tests")
    
    if passed == len(results):
        print("🎉 All tests passed! Backend is working correctly.")
    else:
        print("⚠️  Some tests failed. Check the backend setup.")

if __name__ == '__main__':
    main()
