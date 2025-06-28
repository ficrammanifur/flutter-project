import mysql.connector
from mysql.connector import Error
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'database': os.getenv('DB_NAME', 'sai'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''),
    'port': int(os.getenv('DB_PORT', 3306)),
    'charset': 'utf8mb4',
    'autocommit': False,
    'raise_on_warnings': True
}

def get_db_connection():
    """Create database connection."""
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        if connection.is_connected():
            print("[DEBUG] Database connection established")
            return connection
    except Error as e:
        print(f"[DB] Connection error: {e}")
    except Exception as e:
        print(f"[DB] General error: {e}")
    return None

def test_connection():
    """Test database connection."""
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
            print(f"[DEBUG] Connection test successful: {result}")
            return True
        except Exception as e:
            print(f"[DB] Connection test failed: {e}")
            return False
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()
                print("[DEBUG] Database connection closed")
    return False

def init_database():
    """Initialize database and tables."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        if conn is None:
            print("[DB] Failed to get database connection")
            return False

        cursor = conn.cursor()

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            email VARCHAR(255) UNIQUE NOT NULL,
            password TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        """)

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS schedules (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            hari VARCHAR(20) NOT NULL,
            waktu VARCHAR(20) NOT NULL,
            kode_matkul VARCHAR(20) NOT NULL,
            nama_matkul VARCHAR(100) NOT NULL,
            sks INT NOT NULL,
            kelas VARCHAR(50) NOT NULL,
            dosen VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
            INDEX idx_user_hari (user_id, hari),
            INDEX idx_waktu (waktu)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        """)

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS chat_history (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            message TEXT NOT NULL,
            response TEXT NOT NULL,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
            INDEX idx_user_timestamp (user_id, timestamp)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        """)

        conn.commit()
        print("[DEBUG] Database initialization successful")
        
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()
        print(f"[DEBUG] Available tables: {[table[0] for table in tables]}")
        
        return True

    except Error as e:
        print(f"[DB] Initialization error: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()
            print("[DEBUG] Database connection closed")

def execute_query(query, params=None, fetch=False, fetch_one=False):
    """Execute query with parameters."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        if conn is None:
            print("[DB] Failed to get database connection")
            return None

        cursor = conn.cursor(dictionary=True)
        
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)

        if fetch:
            if fetch_one:
                result = cursor.fetchone()
            else:
                result = cursor.fetchall()
            return result
        else:
            conn.commit()
            return cursor.rowcount

    except Error as e:
        print(f"[DB] Query error: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()
            print("[DEBUG] Database connection closed")

def get_user_by_email(email):
    """Get user by email."""
    query = "SELECT * FROM users WHERE email = %s"
    return execute_query(query, (email,), fetch=True, fetch_one=True)

def get_user_by_id(user_id):
    """Get user by ID."""
    query = "SELECT * FROM users WHERE id = %s"
    return execute_query(query, (user_id,), fetch=True, fetch_one=True)

def create_user(name, email, password):
    """Create a new user."""
    query = "INSERT INTO users (name, email, password) VALUES (%s, %s, %s)"
    result = execute_query(query, (name, email, password))
    return result is not None and result > 0

def get_user_schedules(user_id):
    """Get all schedules for a user."""
    query = """
    SELECT * FROM schedules 
    WHERE user_id = %s 
    ORDER BY 
        CASE hari 
            WHEN 'Monday' THEN 1 
            WHEN 'Tuesday' THEN 2 
            WHEN 'Wednesday' THEN 3 
            WHEN 'Thursday' THEN 4 
            WHEN 'Friday' THEN 5 
            WHEN 'Saturday' THEN 6 
            WHEN 'Sunday' THEN 7 
        END, waktu
    """
    return execute_query(query, (user_id,), fetch=True)

def get_today_schedules(user_id, hari):
    """Get today's schedules for a user."""
    query = """
    SELECT * FROM schedules 
    WHERE user_id = %s AND hari = %s
    ORDER BY waktu
    """
    return execute_query(query, (user_id, hari), fetch=True)

def add_schedule(user_id, hari, waktu, kode_matkul, nama_matkul, sks, kelas, dosen):
    """Add a new schedule."""
    query = """
    INSERT INTO schedules 
    (user_id, hari, waktu, kode_matkul, nama_matkul, sks, kelas, dosen) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    result = execute_query(query, (user_id, hari, waktu, kode_matkul, nama_matkul, sks, kelas, dosen))
    return result is not None and result > 0

def update_schedule(jadwal_id, update_data):
    """Update an existing schedule."""
    if not update_data:
        return False

    fields = [f"{key} = %s" for key in update_data.keys()]
    query = f"UPDATE schedules SET {', '.join(fields)} WHERE id = %s"
    params = list(update_data.values()) + (jadwal_id,)
    
    result = execute_query(query, params)
    return result is not None and result > 0

def delete_schedule(jadwal_id):
    """Delete a schedule."""
    query = "DELETE FROM schedules WHERE id = %s"
    result = execute_query(query, (jadwal_id,))
    return result is not None and result > 0

def save_chat_history(user_id, message, response):
    """Save chat history."""
    query = "INSERT INTO chat_history (user_id, message, response) VALUES (%s, %s, %s)"
    result = execute_query(query, (user_id, message, response))
    return result is not None and result > 0

def get_chat_history(user_id, limit=10):
    """Get user chat history."""
    query = """
    SELECT id, user_id, message, response, timestamp 
    FROM chat_history 
    WHERE user_id = %s 
    ORDER BY timestamp DESC 
    LIMIT %s
    """
    return execute_query(query, (user_id, limit), fetch=True)

# Test database connection on module load
if __name__ == "__main__":
    print("[DEBUG] Testing database connection...")
    if test_connection():
        print("[DEBUG] Database connection successful!")
        if init_database():
            print("[DEBUG] Database initialization successful!")
        else:
            print("[DB] Database initialization failed!")
    else:
        print("[ERROR] Database connection failed!")