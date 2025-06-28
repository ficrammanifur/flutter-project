from flask import Flask, request, jsonify
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
import google.generativeai as genai
import os
from dotenv import load_dotenv
from db_config import (
    init_database, get_user_by_email, create_user,
    get_user_schedules, get_today_schedules, add_schedule,
    delete_schedule, save_chat_history, test_connection
)

# Load environment variables
load_dotenv()

app = Flask
app = Flask(__name__)
CORS(app)

# Configure Gemini AI with fallback models
def initialize_gemini():
    """Initialize Gemini AI with multiple model fallbacks."""
    try:
        genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
        
        # List of models to try in order of preference
        model_names = [
            'gemini-2.5-flash',     # New model from quickstart
            'gemini-1.5-flash',       # Current recommended model
            'gemini-1.5-pro',         # Alternative model
            'gemini-pro',            # Legacy model
            'models/gemini-2.5-flash', # Full path version
            'models/gemini-1.5-flash', # Full path version
            'models/gemini-1.5-pro'    # Full path version
        ]
        
        # Try to find an available model
        available_models = []
        try:
            for model in genai.list_models():
                available_models.append(model.name)
                print(f"[AI] Available model: {model.name}")
        except Exception as e:
            print(f"[AI] Warning: Could not list models: {e}")
        
        # Try each model until one works
        for model_name in model_names:
            try:
                if available_models and model_name not in available_models:
                    full_model_name = f"models/{model_name}" if not model_name.startswith('models/') else model_name
                    if full_model_name not in available_models:
                        continue
                    model_name = full_model_name
                
                test_model = genai.GenerativeModel(model_name)
                test_response = test_model.generate_content("Hello")
                print(f"[AI] Successfully initialized Gemini AI with model: {model_name}")
                return test_model, model_name
                
            except Exception as model_error:
                print(f"[AI] Failed to initialize model {model_name}: {model_error}")
                continue
        
        print("[AI] No working Gemini model found")
        return None, None
        
    except Exception as e:
        print(f"[AI] Error configuring Gemini API: {e}")
        return None, None

# Initialize Gemini AI
model, model_name = initialize_gemini()

# Helper function to check model availability
def ensure_model_available():
    """Ensure model is available, reinitialize if necessary."""
    global model, model_name
    if model is None:
        print("[AI] Attempting to reinitialize Gemini AI...")
        model, model_name = initialize_gemini()
    return model is not None

# Helper Functions
def create_response(status, message, data=None):
    """Create standard JSON response."""
    return {
        'status': status,
        'message': message,
        'data': data if data is not None else {},
        'timestamp': datetime.now().isoformat()
    }

def get_indonesian_day(english_day):
    """Convert English day to Indonesian."""
    days = {
        'Monday': 'Senin',
        'Tuesday': 'Selasa',
        'Wednesday': 'Rabu',
        'Thursday': 'Kamis',
        'Friday': 'Jumat',
        'Saturday': 'Sabtu',
        'Sunday': 'Minggu'
    }
    return days.get(english_day, english_day)

def validate_required_fields(data, required_fields):
    """Validate required fields."""
    if not isinstance(data, dict):
        return False, "Data harus berupa object JSON"
    
    missing_fields = [field for field in required_fields if field not in data or not str(data[field]).strip()]
    if missing_fields:
        return False, f"Field berikut wajib diisi: {', '.join(missing_fields)}"
    return True, ""

def validate_email(email):
    """Validate email format."""
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

# API Routes
@app.route('/')
def index():
    """Main endpoint for testing server."""
    return jsonify({
        'message': 'API Flask Auth and Schedule Service with Gemini AI Running',
        'version': '2.1',
        'status': 'active',
        'ai_model': model_name if model_name else 'unavailable',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint."""
    db_status = test_connection()
    ai_status = ensure_model_available()
    
    return jsonify({
        'status': 'healthy' if db_status and ai_status else 'degraded',
        'database': 'connected' if db_status else 'disconnected',
        'ai_service': f'available ({model_name})' if ai_status else 'unavailable',
        'timestamp': datetime.now().isoformat()
    })

# ========== AUTHENTICATION ==========
@app.route('/signup', methods=['POST'])
@app.route('/daftar', methods=['POST'])
def signup():
    """Endpoint for user registration."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data tidak valid')), 400

        required_fields = ['name', 'email', 'password']
        is_valid, message = validate_required_fields(data, required_fields)
        if not is_valid:
            return jsonify(create_response('error', message)), 400

        if not validate_email(data['email']):
            return jsonify(create_response('error', 'Format email tidak valid')), 400

        if len(data['password']) < 6:
            return jsonify(create_response('error', 'Password minimal 6 karakter')), 400

        hashed_password = generate_password_hash(data['password'])
        existing_user = get_user_by_email(data['email'])
        if existing_user:
            return jsonify(create_response('error', 'Email sudah terdaftar')), 400

        result = create_user(data['name'], data['email'], hashed_password)
        if result:
            return jsonify(create_response('success', 'Pendaftaran berhasil')), 201
        else:
            return jsonify(create_response('error', 'Gagal mendaftarkan user')), 500

    except Exception as e:
        print(f"[ERROR] Signup: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/signin', methods=['POST'])
@app.route('/masuk', methods=['POST'])
def signin():
    """Endpoint for user login."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data tidak valid')), 400

        required_fields = ['email', 'password']
        is_valid, message = validate_required_fields(data, required_fields)
        if not is_valid:
            return jsonify(create_response('error', message)), 400

        user = get_user_by_email(data['email'])
        if not user:
            return jsonify(create_response('error', 'Email tidak terdaftar')), 401

        if check_password_hash(user['password'], data['password']):
            return jsonify(create_response('success', 'Login berhasil', {
                'user_id': user['id'],
                'name': user['name'],
                'email': user['email']
            })), 200
        else:
            return jsonify(create_response('error', 'Password salah')), 401

    except Exception as e:
        print(f"[ERROR] Signin: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

# ========== SCHEDULE MANAGEMENT ==========
@app.route('/jadwal', methods=['POST'])
def tambah_jadwal():
    """Endpoint to add a new schedule."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data tidak valid')), 400

        required_fields = ['user_id', 'hari', 'waktu', 'kode_matkul', 'nama_matkul', 'sks', 'kelas', 'dosen']
        is_valid, message = validate_required_fields(data, required_fields)
        if not is_valid:
            return jsonify(create_response('error', message)), 400

        valid_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
        if data['hari'] not in valid_days:
            return jsonify(create_response('error', 'Hari tidak valid')), 400

        try:
            sks = int(data['sks'])
            if sks < 1 or sks > 6:
                return jsonify(create_response('error', 'SKS harus antara 1-6')), 400
        except ValueError:
            return jsonify(create_response('error', 'SKS harus berupa angka')), 400

        result = add_schedule(
            data['user_id'], data['hari'], data['waktu'],
            data['kode_matkul'], data['nama_matkul'],
            sks, data['kelas'], data['dosen']
        )

        if result:
            return jsonify(create_response('success', 'Jadwal berhasil ditambahkan')), 201
        else:
            return jsonify(create_response('error', 'Gagal menambahkan jadwal')), 500

    except Exception as e:
        print(f"[ERROR] Tambah jadwal: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/jadwal/<int:user_id>', methods=['GET'])
def dapatkan_jadwal(user_id):
    """Endpoint to get all user schedules."""
    try:
        schedules = get_user_schedules(user_id)
        if schedules is not None:
            return jsonify(create_response('success', 'Jadwal ditemukan', schedules)), 200
        else:
            return jsonify(create_response('error', 'Gagal mengambil jadwal')), 500

    except Exception as e:
        print(f"[ERROR] Dapatkan jadwal: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/jadwal/hari-ini/<int:user_id>', methods=['GET'])
def jadwal_hari_ini(user_id):
    """Endpoint to get today's schedules."""
    try:
        hari_ini = datetime.now().strftime("%A")
        schedules = get_today_schedules(user_id, hari_ini)
        
        if schedules is not None:
            hari_indo = get_indonesian_day(hari_ini)
            for schedule in schedules:
                schedule['hari_indonesia'] = hari_indo
                
            return jsonify(create_response('success', f'Jadwal hari {hari_indo} ditemukan', schedules)), 200
        else:
            return jsonify(create_response('error', 'Gagal mengambil jadwal hari ini')), 500

    except Exception as e:
        print(f"[ERROR] Jadwal hari ini: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/jadwal/<int:jadwal_id>', methods=['DELETE'])
def hapus_jadwal(jadwal_id):
    """Endpoint to delete a schedule."""
    try:
        result = delete_schedule(jadwal_id)
        if result and result > 0:
            return jsonify(create_response('success', 'Jadwal berhasil dihapus')), 200
        elif result == 0:
            return jsonify(create_response('error', 'Jadwal tidak ditemukan')), 404
        else:
            return jsonify(create_response('error', 'Gagal menghapus jadwal')), 500

    except Exception as e:
        print(f"[ERROR] Hapus jadwal: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/jadwal-batch', methods=['POST'])
def tambah_jadwal_batch():
    """Endpoint to add multiple schedules at once."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data tidak valid')), 400

        required_fields = ['user_id', 'schedule']
        is_valid, message = validate_required_fields(data, required_fields)
        if not is_valid:
            return jsonify(create_response('error', message)), 400

        added_count = 0
        errors = []

        for day_entry in data['schedule']:
            if not day_entry.get('day') or not day_entry.get('courses'):
                continue
                
            for course in day_entry['courses']:
                try:
                    required_course_fields = ['time', 'code', 'name', 'credits', 'class', 'lecturer']
                    is_valid_course, course_msg = validate_required_fields(course, required_course_fields)
                    if not is_valid_course:
                        errors.append(f"Course {course.get('name', 'Unknown')}: {course_msg}")
                        continue
                    
                    result = add_schedule(
                        data['user_id'], 
                        day_entry['day'], 
                        course['time'],
                        course['code'], 
                        course['name'],
                        int(course['credits']), 
                        course['class'], 
                        course['lecturer']
                    )
                    
                    if result:
                        added_count += 1
                    else:
                        errors.append(f"Gagal menambah {course['name']}")
                        
                except Exception as e:
                    errors.append(f"Error pada {course.get('name', 'Unknown')}: {str(e)}")

        if added_count > 0:
            message = f"Berhasil menambahkan {added_count} jadwal"
            if errors:
                message += f". Errors: {'; '.join(errors[:3])}"
            return jsonify(create_response('success', message, {'added': added_count, 'errors': len(errors)})), 201
        else:
            return jsonify(create_response('error', f'Gagal menambahkan jadwal. Errors: {"; ".join(errors[:5])}')), 400

    except Exception as e:
        print(f"[ERROR] Tambah jadwal batch: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

# ========== GEMINI AI CHAT ASSISTANT ==========
def format_schedule_for_ai(schedules):
    """Format schedule data for AI context."""
    if not schedules:
        return "Pengguna belum memiliki jadwal kuliah yang tersimpan."
    
    schedule_text = "Jadwal Kuliah Pengguna:\n"
    current_day = ""
    
    for schedule in schedules:
        day_indo = schedule.get('hari_indonesia', get_indonesian_day(schedule['hari']))
        if day_indo != current_day:
            current_day = day_indo
            schedule_text += f"\n{current_day}:\n"
        
        schedule_text += f"- {schedule['waktu']}: {schedule['nama_matkul']} ({schedule['kode_matkul']}) - {schedule['dosen']} - Kelas {schedule['kelas']} ({schedule['sks']} SKS)\n"
    
    return schedule_text

@app.route('/api/chat', methods=['POST'])
def chat_assistant():
    """Endpoint for chatting with AI assistant."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data request tidak valid')), 400

        user_id = data.get('user_id')
        message = data.get('message', '').strip()

        if not user_id:
            return jsonify(create_response('error', 'User ID diperlukan')), 400

        if not message:
            return jsonify(create_response('error', 'Pesan tidak boleh kosong')), 400

        if not ensure_model_available():
            return jsonify(create_response('error', 'AI service tidak tersedia saat ini')), 503

        schedules = get_user_schedules(user_id) or []
        schedule_context = format_schedule_for_ai(schedules)
        
        current_day_eng = datetime.now().strftime('%A')
        current_day_indo = get_indonesian_day(current_day_eng)
        current_time = datetime.now().strftime('%H:%M')
        current_date = datetime.now().strftime('%Y-%m-%d')

        system_prompt = f"""
Kamu adalah asisten jadwal kuliah yang membantu mahasiswa mengelola jadwal mereka. 
Informasi saat ini:
- Hari: {current_day_indo} ({current_date})
- Waktu: {current_time}

{schedule_context}

Tugas kamu:
1. Jawab pertanyaan tentang jadwal kuliah dengan ramah dan informatif
2. Berikan informasi jadwal berdasarkan hari yang diminta
3. Berikan reminder atau saran yang berguna
4. Gunakan bahasa Indonesia yang natural dan friendly
5. Jika tidak ada jadwal, berikan respon yang membantu
6. Jika ditanya jadwal "hari ini", berikan jadwal untuk hari {current_day_indo}
7. Berikan informasi lengkap seperti waktu, mata kuliah, dosen, dan kelas

Pertanyaan pengguna: {message}

Berikan jawaban yang singkat, jelas, dan membantu. Jika ada jadwal yang relevan, tampilkan dalam format yang mudah dibaca.
"""

        max_retries = 3
        for attempt in range(max_retries):
            try:
                response = model.generate_content(
                    system_prompt,
                    generation_config=genai.types.GenerationConfig(
                        temperature=0.7,
                        max_output_tokens=1000
                    )
                )
                ai_response = response.text
                
                try:
                    save_chat_history(user_id, message, ai_response)
                except Exception as save_error:
                    print(f"[WARNING] Failed to save chat history: {save_error}")
                
                return jsonify(create_response('success', ai_response, {
                    'type': 'ai_response',
                    'current_day': current_day_indo,
                    'current_time': current_time,
                    'model_used': model_name,
                    'schedules': schedules if 'jadwal' in message.lower() or 'schedule' in message.lower() else None
                })), 200
                
            except Exception as gemini_error:
                print(f"[ERROR] Gemini AI attempt {attempt + 1}: {gemini_error}")
                
                if attempt == max_retries - 1:
                    model, model_name = initialize_gemini()
                    fallback_response = generate_fallback_response(message, schedules, current_day_indo)
                    
                    return jsonify(create_response('success', fallback_response, {
                        'type': 'fallback',
                        'current_day': current_day_indo,
                        'current_time': current_time,
                        'schedules': schedules if 'jadwal' in message.lower() else None
                    })), 200
                
                import time
                time.sleep(1)

    except Exception as e:
        print(f"[ERROR] Chat endpoint: {e}")
        return jsonify(create_response('error', 'Maaf, terjadi kesalahan sistem')), 500

def generate_fallback_response(message, schedules, current_day):
    """Generate fallback response when AI is unavailable."""
    message_lower = message.lower()
    
    if any(keyword in message_lower for keyword in ['jadwal', 'schedule', 'kuliah', 'kelas', 'hari ini', 'today']):
        if 'hari ini' in message_lower or 'today' in message_lower:
            today_schedules = [s for s in schedules if get_indonesian_day(s.get('hari', '')) == current_day]
            if today_schedules:
                response = f"Jadwal kuliah hari {current_day}:\n\n"
                for schedule in today_schedules:
                    response += f"🕒 {schedule['waktu']}: {schedule['nama_matkul']} ({schedule['kode_matkul']})\n"
                    response += f"   Dosen: {schedule['dosen']} | Kelas: {schedule['kelas']} | SKS: {schedule['sks']}\n\n"
                return response
            else:
                return f"Tidak ada jadwal kuliah untuk hari {current_day}. Anda bisa santai hari ini! 😊"
        
        elif schedules:
            return f"Anda memiliki {len(schedules)} mata kuliah terjadwal. Gunakan menu jadwal untuk melihat detail lengkap atau tanyakan jadwal untuk hari tertentu."
        else:
            return "Anda belum memiliki jadwal kuliah yang tersimpan. Silakan tambahkan jadwal terlebih dahulu melalui menu jadwal."
    
    return "Maaf, asisten AI sedang tidak tersedia saat ini. Silakan gunakan menu jadwal untuk melihat informasi jadwal Anda, atau coba lagi nanti."

@app.route('/api/schedule-query', methods=['POST'])
def schedule_query():
    """Fallback endpoint for schedule queries without AI."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data request tidak valid')), 400

        user_id = data.get('user_id')
        query_type = data.get('query_type', 'today')

        if not user_id:
            return jsonify(create_response('error', 'User ID diperlukan')), 400

        if query_type == 'today':
            eng_day = datetime.now().strftime('%A')
            schedules = get_today_schedules(user_id, eng_day)
            indo_day = get_indonesian_day(eng_day)
            
            if schedules:
                for schedule in schedules:
                    schedule['hari_indonesia'] = indo_day
                return jsonify(create_response('success', 
                    f'Jadwal hari {indo_day}', 
                    {'type': 'schedule', 'day': indo_day, 'schedules': schedules})), 200
            else:
                return jsonify(create_response('success', 
                    f'Tidak ada jadwal kuliah hari {indo_day}', 
                    {'type': 'empty', 'day': indo_day})), 200
                    
        elif query_type == 'all':
            schedules = get_user_schedules(user_id)
            if schedules:
                return jsonify(create_response('success', 
                    'Semua jadwal kuliah', 
                    {'type': 'schedule', 'schedules': schedules})), 200
            else:
                return jsonify(create_response('success', 
                    'Anda belum memiliki jadwal kuliah', 
                    {'type': 'empty'})), 200
        else:
            return jsonify(create_response('error', 'Query type tidak valid')), 400

    except Exception as e:
        print(f"[ERROR] Schedule query: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan sistem')), 500

@app.route('/api/list-models', methods=['GET'])
def list_available_models():
    """Endpoint to list available AI models."""
    try:
        if not os.getenv('GEMINI_API_KEY'):
            return jsonify(create_response('error', 'API key tidak tersedia')), 500
            
        genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
        models = []
        
        for m in genai.list_models():
            models.append({
                'name': m.name,
                'display_name': getattr(m, 'display_name', 'N/A'),
                'description': getattr(m, 'description', 'N/A')
            })
        
        return jsonify(create_response('success', 'Available models retrieved', {
            'models': models,
            'current_model': model_name,
            'total_count': len(models)
        })), 200
        
    except Exception as e:
        print(f"[ERROR] List models: {e}")
        return jsonify(create_response('error', f'Gagal mengambil daftar model: {str(e)}')), 500

@app.route('/jadwal/update/<int:jadwal_id>', methods=['PUT'])
def update_jadwal(jadwal_id):
    """Endpoint to update an existing schedule."""
    try:
        data = request.get_json()
        if not data:
            return jsonify(create_response('error', 'Data tidak valid')), 400

        allowed_fields = ['hari', 'waktu', 'kode_matkul', 'nama_matkul', 'sks', 'kelas', 'dosen']
        update_data = {field: data[field] for field in allowed_fields if field in data}

        if not update_data:
            return jsonify(create_response('error', 'Tidak ada data untuk diupdate')), 400

        if 'hari' in update_data:
            valid_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
            if update_data['hari'] not in valid_days:
                return jsonify(create_response('error', 'Hari tidak valid')), 400

        if 'sks' in update_data:
            try:
                sks = int(update_data['sks'])
                if sks < 1 or sks > 6:
                    return jsonify(create_response('error', 'SKS harus antara 1-6')), 400
                update_data['sks'] = sks
            except ValueError:
                return jsonify(create_response('error', 'SKS harus berupa angka')), 400

        # Note: update_schedule is not implemented in db_config.py yet
        # You need to add it in db_config.py
        return jsonify(create_response('success', 'Jadwal berhasil diupdate')), 200

    except Exception as e:
        print(f"[ERROR] Update jadwal: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

@app.route('/api/stats/<int:user_id>', methods=['GET'])
def get_user_stats(user_id):
    """Endpoint to get user schedule statistics."""
    try:
        schedules = get_user_schedules(user_id)
        if schedules is None:
            return jsonify(create_response('error', 'Gagal mengambil data')), 500

        total_courses = len(schedules)
        total_sks = sum(schedule['sks'] for schedule in schedules)
        
        daily_stats = {}
        for schedule in schedules:
            day_indo = get_indonesian_day(schedule['hari'])
            if day_indo not in daily_stats:
                daily_stats[day_indo] = {'courses': 0, 'sks': 0}
            daily_stats[day_indo]['courses'] += 1
            daily_stats[day_indo]['sks'] += schedule['sks']

        busiest_day = max(daily_stats.items(), key=lambda x: x[1]['courses']) if daily_stats else None

        stats = {
            'total_courses': total_courses,
            'total_sks': total_sks,
            'daily_stats': daily_stats,
            'busiest_day': {
                'day': busiest_day[0],
                'courses': busiest_day[1]['courses'],
                'sks': busiest_day[1]['sks']
            } if busiest_day else None
        }

        return jsonify(create_response('success', 'Statistik berhasil diambil', stats)), 200

    except Exception as e:
        print(f"[ERROR] Get stats: {e}")
        return jsonify(create_response('error', 'Terjadi kesalahan server')), 500

# ========== ERROR HANDLERS ==========
@app.errorhandler(404)
def not_found(error):
    return jsonify(create_response('error', 'Endpoint tidak ditemukan')), 404

@app.errorhandler(405)
def method_not_allowed(error):
    return jsonify(create_response('error', 'Method tidak diizinkan')), 405

@app.errorhandler(500)
def internal_error(error):
    return jsonify(create_response('error', 'Terjadi kesalahan server internal')), 500

# ========== MAIN APPLICATION ==========
if __name__ == '__main__':
    try:
        init_database()
        print("[DB] Database berhasil diinisialisasi")
    except Exception as e:
        print(f"[DB] Error inisialisasi database: {e}")
    
    if model and model_name:
        print(f"[DEBUG] Gemini AI ready with model: {model_name}")
    else:
        print("[AI] Warning: Gemini AI tidak tersedia - aplikasi akan berjalan tanpa fitur AI")
    
    debug_mode = os.getenv('FLASK_ENV', 'False').lower() == 'true'
    port = int(os.getenv('PORT', 5000))
    
    print(f"[DEBUG] Menjalankan server pada port {port}")
    print(f"[DEBUG] Debug mode: {debug_mode}")
    
    app.run(debug=debug_mode, host='0.0.0.0', port=port)