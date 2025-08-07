import firebase_admin
from firebase_admin import credentials, db
import os

def initialize_firebase():
    if not firebase_admin._apps:
        # Pastikan file serviceAccountKey.json ada di folder ini
        cred = credentials.Certificate('serviceAccountKey.json')
        
        # Pastikan sudah set environment variable FIREBASE_DATABASE_URL
        database_url = os.getenv('FIREBASE_DATABASE_URL')
        if not database_url:
            raise ValueError("❌ FIREBASE_DATABASE_URL environment variable is not set.")
        
        firebase_admin.initialize_app(cred, {
            'databaseURL': database_url
        })
        print('✅ Firebase initialized successfully')
    
    return db
