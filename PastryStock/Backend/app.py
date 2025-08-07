from flask import Flask, jsonify, request
from flask_cors import CORS
from firebase_admin import credentials, db, auth, initialize_app
import bcrypt
from datetime import datetime, date, timedelta
import json
import google.generativeai as genai
import os
from dotenv import load_dotenv
from functools import wraps
import numpy as np
from statsmodels.tsa.arima.model import ARIMA

# Load environment variables from .env
load_dotenv()

# Initialize Flask
app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})

# Initialize Firebase Realtime Database and Authentication
try:
    firebase_credentials = os.getenv('FIREBASE_CREDENTIALS')
    if not firebase_credentials:
        raise ValueError("FIREBASE_CREDENTIALS not found in .env")
    if not os.path.exists(firebase_credentials):
        raise FileNotFoundError(f"FIREBASE_CREDENTIALS path does not exist: {firebase_credentials}")
    cred = credentials.Certificate(firebase_credentials)
    initialize_app(cred, {
        'databaseURL': os.getenv('FIREBASE_DATABASE_URL')
    })
    print("✅ Firebase initialized successfully")
except Exception as e:
    print(f"[ERROR] Failed to initialize Firebase: {e}")
    raise

# Initialize Gemini AI with fallback
def initialize_gemini():
    try:
        genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
        model_names = [
            'gemini-2.5-flash',
            'gemini-1.5-flash',
            'gemini-1.5-pro',
            'gemini-pro',
            'models/gemini-2.5-flash',
            'models/gemini-1.5-flash',
            'models/gemini-1.5-pro'
        ]
        available_models = []
        try:
            for model in genai.list_models():
                available_models.append(model.name)
                print(f"[AI] Available model: {model.name}")
        except Exception as e:
            print(f"[AI] Warning: Could not list models: {e}")
        selected_model = None
        for name in model_names:
            if name in available_models or 'models/' + name in available_models:
                selected_model = name
                break
        if selected_model:
            print(f"[AI] Using model: {selected_model}")
            return genai.GenerativeModel(selected_model)
        else:
            print("[AI] No preferred models found, fallback to gemini-pro")
            return genai.GenerativeModel('gemini-pro')
    except Exception as e:
        print(f"[AI] Error initializing Gemini AI: {e}")
        return genai.GenerativeModel('gemini-pro')

model = initialize_gemini()

# Helper to serialize datetime
def serialize_datetime(obj):
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    raise TypeError("Type not serializable")

# Middleware to verify user ID
def verify_user(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        user_id = request.headers.get('X-User-ID')
        if not user_id:
            print("[DEBUG] Missing X-User-ID header")
            return jsonify({'error': 'User ID required'}), 401
        try:
            user = auth.get_user(user_id)
            ref = db.reference(f'users/{user_id}')
            user_data = ref.get()
            if not user_data:
                print("[DEBUG] User data not found in database")
                return jsonify({'error': 'User not found'}), 404
            request.user = {'uid': user_id, **user_data}
            return f(*args, **kwargs)
        except auth.UserNotFoundError:
            print("[DEBUG] User ID not found in Firebase Authentication")
            return jsonify({'error': 'Invalid user ID'}), 401
        except Exception as e:
            print(f"[ERROR] User verification failed: {e}")
            return jsonify({'error': 'User verification failed'}), 401
    return decorated_function

# AUTH ROUTES (unchanged)
@app.route('/api/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        print(f"[DEBUG] Login attempt: {data}")
        email = data.get('email')
        password = data.get('password')
        if not email or not password:
            print("[DEBUG] Missing email or password")
            return jsonify({'error': 'Email dan password diperlukan'}), 400
        try:
            user = auth.get_user_by_email(email)
            print(f"[DEBUG] User found: UID={user.uid}")
            ref = db.reference(f'users/{user.uid}')
            user_data = ref.get()
            if not user_data:
                print("[DEBUG] User data not found in database")
                return jsonify({'error': 'Data pengguna tidak ditemukan'}), 404
            stored_hash = user_data.get('password_hash')
            if not stored_hash or not bcrypt.checkpw(password.encode('utf-8'), stored_hash.encode('utf-8')):
                print("[DEBUG] Password mismatch or hash not found")
                return jsonify({'error': 'Kata sandi salah'}), 401
            print("[DEBUG] Login successful")
            return jsonify({
                'user': {
                    'id': user.uid,
                    'name': user_data.get('name', 'User'),
                    'email': user.email,
                    'role': user_data.get('role', 'user')
                }
            }), 200
        except auth.UserNotFoundError:
            print("[DEBUG] Email not found")
            return jsonify({'error': 'Email tidak ditemukan'}), 404
        except Exception as e:
            print(f"[ERROR] login: {e}")
            return jsonify({'error': str(e)}), 400
    except Exception as e:
        print(f"[ERROR] login: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/signup', methods=['POST'])
def signup():
    try:
        data = request.get_json()
        print(f"[DEBUG] Signup attempt: {data}")
        email = data.get('email')
        password = data.get('password')
        name = data.get('name')
        if not email or not password or not name:
            print("[DEBUG] Missing name, email, or password")
            return jsonify({'error': 'Nama, email, dan password diperlukan'}), 400
        if len(password) < 6:
            print("[DEBUG] Password too short")
            return jsonify({'error': 'Password harus minimal 6 karakter'}), 400
        try:
            user = auth.create_user(
                email=email,
                password=password,
                display_name=name
            )
            password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
            ref = db.reference(f'users/{user.uid}')
            user_data = {
                'name': name,
                'email': email,
                'role': 'user',
                'created_at': datetime.now().isoformat(),
                'password_hash': password_hash
            }
            ref.set(user_data)
            print(f"[DEBUG] User created: UID={user.uid}, Data={user_data}")
            return jsonify({
                'user': {
                    'id': user.uid,
                    'name': name,
                    'email': email,
                    'role': 'user'
                }
            }), 201
        except auth.EmailAlreadyExistsError:
            print("[DEBUG] Email already exists")
            return jsonify({'error': 'Email sudah terdaftar'}), 400
        except Exception as e:
            print(f"[ERROR] signup: {e}")
            return jsonify({'error': str(e)}), 400
    except Exception as e:
        print(f"[ERROR] signup: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/reset-password', methods=['POST'])
def reset_password():
    try:
        data = request.get_json()
        print(f"[DEBUG] Reset password attempt: {data}")
        email = data.get('email')
        if not email:
            print("[DEBUG] Missing email")
            return jsonify({'error': 'Email diperlukan'}), 400
        if '@' not in email or '.' not in email:
            print("[DEBUG] Invalid email format")
            return jsonify({'error': 'Format email tidak valid'}), 400
        try:
            auth.generate_password_reset_link(email)
            print("[DEBUG] Password reset link sent")
            return jsonify({'message': 'Link reset password telah dikirim ke email'}), 200
        except auth.UserNotFoundError:
            print("[DEBUG] Email not found")
            return jsonify({'error': 'Email tidak ditemukan'}), 404
        except Exception as e:
            print(f"[ERROR] reset_password: {e}")
            return jsonify({'error': str(e)}), 400
    except Exception as e:
        print(f"[ERROR] reset_password: {e}")
        return jsonify({'error': str(e)}), 500

# USER ROUTES (unchanged)
@app.route('/api/users/<user_id>', methods=['GET'])
@verify_user
def get_user(user_id):
    try:
        print(f"[DEBUG] Fetching user: user_id={user_id}")
        ref = db.reference(f'users/{user_id}')
        user_data = ref.get()
        if user_data:
            print(f"[DEBUG] User data found: {user_data}")
            return jsonify({
                'id': user_id,
                'name': user_data.get('name', 'User'),
                'email': user_data.get('email'),
                'role': user_data.get('role', 'user'),
                'created_at': user_data.get('created_at')
            }), 200
        print("[DEBUG] User not found")
        return jsonify({'error': 'User not found'}), 404
    except Exception as e:
        print(f"[ERROR] get_user: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/users/<user_id>', methods=['PUT'])
@verify_user
def update_user(user_id):
    try:
        data = request.get_json()
        print(f"[DEBUG] Updating user: user_id={user_id}, Data={data}")
        if not data:
            print("[DEBUG] No data provided")
            return jsonify({'error': 'No data provided'}), 400

        ref = db.reference(f'users/{user_id}')
        user_data = ref.get()
        if not user_data:
            print("[DEBUG] User data not found in database")
            return jsonify({'error': 'User not found'}), 404

        updates = {}
        if 'name' in data:
            updates['name'] = data['name']
            auth.update_user(user_id, display_name=data['name'])
        if 'email' in data:
            updates['email'] = data['email']
            auth.update_user(user_id, email=data['email'])
        if 'password' in data:
            if len(data['password']) < 6:
                print("[DEBUG] Password too short")
                return jsonify({'error': 'Password harus minimal 6 karakter'}), 400
            auth.update_user(user_id, password=data['password'])
            updates['password_hash'] = bcrypt.hashpw(data['password'].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

        if not updates:
            print("[DEBUG] No valid fields to update")
            return jsonify({'error': 'No valid fields to update'}), 400

        ref.update(updates)
        updated_user = ref.get()
        print(f"[DEBUG] User updated: {updated_user}")
        return jsonify({
            'id': user_id,
            'name': updated_user.get('name', 'User'),
            'email': updated_user.get('email'),
            'role': updated_user.get('role', 'user'),
            'created_at': updated_user.get('created_at')
        }), 200
    except auth.UserNotFoundError:
        print("[DEBUG] User ID not found in Firebase Authentication")
        return jsonify({'error': 'Invalid user ID'}), 401
    except Exception as e:
        print(f"[ERROR] update_user: {e}")
        return jsonify({'error': f'Failed to update user: {str(e)}'}), 400

# SALES ROUTES (unchanged)
@app.route('/api/sales/recent', methods=['GET'])
@verify_user
def get_recent_sales():
    try:
        print("[DEBUG] Fetching recent sales")
        ref = db.reference('sales')
        sales = ref.order_by_child('date').limit_to_last(10).get()
        sales_list = []
        for sale_id, sale_data in (sales or {}).items():
            sale_data['id'] = sale_id
            sales_list.append(sale_data)
        print(f"[DEBUG] Recent sales: {sales_list}")
        return jsonify(sales_list)
    except Exception as e:
        print(f"[ERROR] get_recent_sales: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/sales/today', methods=['GET'])
@verify_user
def get_today_sales():
    try:
        print("[DEBUG] Fetching today's sales")
        ref = db.reference('sales')
        today = datetime.now().date().isoformat()
        sales = ref.order_by_child('date').start_at(today).end_at(today + '\uf8ff').get()
        sales_list = []
        for sale_id, sale_data in (sales or {}).items():
            sale_data['id'] = sale_id
            sales_list.append(sale_data)
        print(f"[DEBUG] Today's sales: {sales_list}")
        return jsonify(sales_list)
    except Exception as e:
        print(f"[ERROR] get_today_sales: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/sales', methods=['POST'])
@verify_user
def add_sale():
    try:
        data = request.get_json()
        print(f"[DEBUG] Adding sale: {data}")
        if not all(key in data for key in ['menuName', 'quantity', 'pricePerItem', 'totalAmount']):
            print("[DEBUG] Missing required fields")
            return jsonify({'error': 'Missing required fields'}), 400
        ref = db.reference('sales')
        new_sale = {
            'menuName': data['menuName'],
            'quantity': data['quantity'],
            'pricePerItem': data['pricePerItem'],
            'totalAmount': data['totalAmount'],
            'date': datetime.now().isoformat()
        }
        new_sale_ref = ref.push(new_sale)
        new_sale['id'] = new_sale_ref.key
        print(f"[DEBUG] Sale added: {new_sale}")
        return jsonify(new_sale), 201
    except Exception as e:
        print(f"[ERROR] add_sale: {e}")
        return jsonify({'error': str(e)}), 400

# INGREDIENTS ROUTES (unchanged except for consumption_history in update_ingredient_stock)
@app.route('/api/ingredients', methods=['GET'])
@verify_user
def get_all_ingredients():
    try:
        print("[DEBUG] Fetching all ingredients")
        ref = db.reference('ingredients')
        ingredients = ref.get()
        ingredients_list = []
        for ing_id, ing_data in (ingredients or {}).items():
            ing_data['id'] = ing_id
            if 'unit' not in ing_data:
                ing_data['unit'] = 'unknown'
            ingredients_list.append(ing_data)
        print(f"[DEBUG] Ingredients: {ingredients_list}")
        return jsonify(ingredients_list)
    except Exception as e:
        print(f"[ERROR] get_all_ingredients: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/ingredients/low-stock', methods=['GET'])
@verify_user
def get_low_stock_ingredients():
    try:
        print("[DEBUG] Fetching low stock ingredients")
        ref = db.reference('ingredients')
        ingredients = ref.get()
        low_stock = []
        for ing_id, ing_data in (ingredients or {}).items():
            if ing_data.get('stockStatus') in ['Kritis', 'Peringatan']:
                ing_data['id'] = ing_id
                if 'unit' not in ing_data:
                    ing_data['unit'] = 'unknown'
                low_stock.append(ing_data)
        print(f"[DEBUG] Low stock ingredients: {low_stock}")
        return jsonify(low_stock)
    except Exception as e:
        print(f"[ERROR] get_low_stock_ingredients: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/ingredients/<ingredient_id>/stock', methods=['PUT'])
@verify_user
def update_ingredient_stock(ingredient_id):
    try:
        data = request.get_json()
        print(f"[DEBUG] Updating stock for ingredient: {ingredient_id}, Data: {data}")
        new_stock = data.get('currentStock')
        if new_stock is None:
            print("[DEBUG] Missing currentStock")
            return jsonify({'error': 'currentStock is required'}), 400
        if new_stock < 0:
            print("[DEBUG] Invalid stock value")
            return jsonify({'error': 'Stock cannot be negative'}), 400
        ref = db.reference(f'ingredients/{ingredient_id}')
        ingredient = ref.get()
        if not ingredient:
            print("[DEBUG] Ingredient not found")
            return jsonify({'error': 'Ingredient not found'}), 404
        old_stock = ingredient.get('currentStock', 0)
        consumption = old_stock - new_stock if old_stock > new_stock else 0
        min_threshold = ingredient.get('minThreshold', 0)
        estimated_days = round(new_stock / 50) if new_stock > 0 else 0
        stock_status = ('Kritis' if new_stock < min_threshold
                       else 'Peringatan' if new_stock < min_threshold * 2
                       else 'Aman')
        updates = {
            'currentStock': new_stock,
            'estimatedDaysLeft': estimated_days,
            'stockStatus': stock_status,
            'unit': ingredient.get('unit', 'unknown')
        }
        ref.update(updates)
        # Catat consumption_history jika ada konsumsi
        if consumption > 0:
            history_ref = db.reference(f'ingredients/{ingredient_id}/consumption_history')
            history_ref.push({
                'date': datetime.now().date().isoformat(),
                'consumption': consumption
            })
            print(f"[DEBUG] Consumption history updated: {consumption} {ingredient.get('unit', 'unknown')}")
        print(f"[DEBUG] Stock updated: {ingredient_id}")
        return jsonify({'message': 'Stock updated successfully'})
    except Exception as e:
        print(f"[ERROR] update_ingredient_stock: {e}")
        return jsonify({'error': str(e)}), 400

@app.route('/api/ingredients', methods=['POST'])
@verify_user
def add_ingredient():
    try:
        data = request.get_json()
        print(f"[DEBUG] Adding ingredient: {data}")
        ingredient_id = data.get('ingredientId')
        if not ingredient_id:
            print("[DEBUG] Missing ingredient ID")
            return jsonify({'error': 'Ingredient ID is required'}), 400
        ingredient_ref = db.reference(f'ingredients/{ingredient_id}')
        ingredient_data = {
            'ingredientId': ingredient_id,
            'ingredientName': data.get('ingredientName'),
            'currentStock': data.get('currentStock', 0),
            'unit': data.get('unit', 'unknown'),
            'dailyConsumption': data.get('dailyConsumption', 0),
            'minThreshold': data.get('minThreshold', 0),
            'status': data.get('status', 'Aman'),
            'recommendation': data.get('recommendation', '')
        }
        ingredient_ref.set(ingredient_data)
        print(f"[DEBUG] Added ingredient: {ingredient_id}")
        return jsonify({'message': 'Ingredient added', 'ingredient': ingredient_data}), 201
    except Exception as e:
        print(f"[ERROR] Adding ingredient: {str(e)}")
        return jsonify({'error': str(e)}), 500

# PREDICTIONS ROUTES (modified to include consumption_history)
@app.route('/api/predictions', methods=['GET'])
@verify_user
def get_stock_predictions():
    try:
        print("[DEBUG] Fetching stock predictions")
        ref = db.reference('ingredients')
        ingredients = ref.get()
        predictions = []
        for ing_id, ing_data in (ingredients or {}).items():
            # Handle inconsistent field names
            ingredient_name = ing_data.get('ingredientName', ing_data.get('name', 'Unknown'))
            current_stock = ing_data.get('currentStock', 0)
            min_threshold = ing_data.get('minThreshold', 0)
            daily_consumption = ing_data.get('dailyConsumption', 0)
            unit = ing_data.get('unit', 'unknown')
            if not ingredient_name or current_stock is None:
                print(f"[WARN] Skipping ingredient {ing_id}: Missing required fields - name={ingredient_name}, currentStock={current_stock}")
                continue
            # Ambil consumption_history
            history_ref = db.reference(f'ingredients/{ing_id}/consumption_history')
            history = history_ref.get() or {}
            consumption_history = [
                {'date': h['date'], 'consumption': float(h['consumption'])}
                for h in history.values()
            ]
            # Hitung predictedDaysUntilEmpty secara deterministik
            predicted_days = current_stock / daily_consumption if daily_consumption > 0 else 0
            # Hitung recommendedReorderQuantity (7 hari konsumsi + minThreshold)
            recommended_reorder = max(0, (daily_consumption * 7 + min_threshold) - current_stock)
            # Tentukan status dan rekomendasi
            status = "Critical" if predicted_days < 1 else "Low Stock" if predicted_days < 3 else "Sufficient"
            recommendation = (
                f"Reorder immediately: Stock will be depleted in {predicted_days:.2f} days. "
                f"Recommended reorder quantity: {recommended_reorder} {unit} to cover 7 days and maintain minimum threshold."
                if predicted_days < 3 else
                f"Stock is sufficient for {predicted_days:.2f} days. Monitor and reorder {recommended_reorder} {unit} when needed."
            )
            prediction = {
                'ingredientId': ing_id,
                'ingredientName': ingredient_name,
                'currentStock': current_stock,
                'minThreshold': min_threshold,
                'unit': unit,
                'predictedDaysUntilEmpty': round(predicted_days, 2),
                'dailyConsumption': daily_consumption,
                'recommendedReorderQuantity': round(recommended_reorder),
                'status': status,
                'recommendation': recommendation,
                'predictionDate': datetime.now().isoformat(),
                'consumptionHistory': consumption_history
            }
            predictions.append(prediction)
        print(f"[DEBUG] Stock predictions: {predictions}")
        return jsonify(predictions)
    except Exception as e:
        print(f"[ERROR] get_stock_predictions: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/predictions/<ingredient_id>/arima', methods=['GET'])
@verify_user
def calculate_arima_prediction(ingredient_id):
    try:
        print(f"[DEBUG] Calculating ARIMA prediction for ingredient: {ingredient_id}")
        ref = db.reference(f'ingredients/{ingredient_id}')
        ingredient = ref.get()
        if not ingredient:
            print("[DEBUG] Ingredient not found")
            return jsonify({'error': 'Ingredient not found'}), 404

        history_ref = db.reference(f'ingredients/{ingredient_id}/consumption_history')
        history = history_ref.get() or []
        if not history:
            print("[DEBUG] No consumption history found")
            return jsonify({'error': 'No consumption history available'}), 400

        consumption_data = [float(h['consumption']) for h in history.values()]
        consumption_history = [
            {'date': h['date'], 'consumption': float(h['consumption'])}
            for h in history.values()
        ]
        if len(consumption_data) < 7:
            print("[DEBUG] Insufficient data for ARIMA")
            return jsonify({'error': 'Insufficient data for ARIMA'}), 400

        try:
            model = ARIMA(consumption_data, order=(1, 1, 1))
            model_fit = model.fit()
            forecast = model_fit.forecast(steps=7)
            forecast = [round(f, 2) for f in forecast]

            current_stock = ingredient.get('currentStock', 0)
            predicted_stock = [current_stock]
            for consumption in forecast:
                current_stock -= consumption
                predicted_stock.append(max(0, round(current_stock, 2)))

            mse = np.mean([(a - b) ** 2 for a, b in zip(consumption_data[-7:], model_fit.fittedvalues[-7:])]) if len(consumption_data) >= 7 else 0
            mae = np.mean([abs(a - b) for a, b in zip(consumption_data[-7:], model_fit.fittedvalues[-7:])]) if len(consumption_data) >= 7 else 0

            trend_direction = 'Decreasing' if forecast[-1] > forecast[0] else 'Increasing' if forecast[-1] < forecast[0] else 'Stable'

            arima_results = {
                'ingredientId': ingredient_id,
                'ingredientName': ingredient.get('ingredientName', 'Unknown'),
                'unit': ingredient.get('unit', 'unknown'),
                'currentStock': ingredient.get('currentStock', 0),
                'predictedConsumption': forecast,
                'predictedStock': predicted_stock,
                'predictionDate': datetime.now().isoformat(),
                'model_params': {'p': 1, 'd': 1, 'q': 1},
                'accuracy_metrics': {'mse': round(mse, 2), 'mae': round(mae, 2), 'mape': 0},
                'confidence_interval': [[f - 10, f + 10] for f in forecast],
                'seasonal_component': 'none',
                'trend_direction': trend_direction,
                'consumptionHistory': consumption_history
            }

            prediction_ref = db.reference(f'predictions/{ingredient_id}')
            prediction_ref.push(arima_results)
            print(f"[DEBUG] ARIMA results saved: {arima_results}")

            return jsonify(arima_results), 200
        except Exception as e:
            print(f"[ERROR] ARIMA model fitting failed: {e}")
            return jsonify({'error': f'ARIMA model fitting failed: {str(e)}'}), 500

    except Exception as e:
        print(f"[ERROR] calculate_arima_prediction: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/predictions/<ingredient_id>/history', methods=['GET'])
@verify_user
def get_prediction_history(ingredient_id):
    try:
        print(f"[DEBUG] Fetching prediction history for ingredient: {ingredient_id}")
        ref = db.reference(f'predictions/{ingredient_id}')
        history = ref.get() or []
        history_list = []
        for prediction_id, prediction_data in history.items():
            prediction_data['id'] = prediction_id
            history_list.append(prediction_data)
        print(f"[DEBUG] Prediction history: {history_list}")
        return jsonify(history_list), 200
    except Exception as e:
        print(f"[ERROR] get_prediction_history: {e}")
        return jsonify({'error': str(e)}), 500

# MENU ITEMS ROUTE (unchanged)
@app.route('/api/menu-items', methods=['GET'])
@verify_user
def get_menu_items():
    try:
        print("[DEBUG] Fetching all menu items")
        ref = db.reference('menu_items')
        menu_items = ref.get() or {}
        menu_items_list = [{"id": k, **v} for k, v in menu_items.items()]
        print(f"[DEBUG] Menu items: {menu_items_list}")
        return jsonify(menu_items_list), 200
    except Exception as e:
        print(f"[ERROR] get_menu_items: {e}")
        return jsonify({'error': str(e)}), 500

# PING ROUTE (unchanged)
@app.route('/api/ping', methods=['GET'])
def ping():
    print("[DEBUG] Ping endpoint called")
    return jsonify({'message': 'Server is alive'}), 200

@app.route('/', methods=['GET'])
def index():
    print("[DEBUG] Index endpoint called")
    ascii_art = """
 __        __   _                            _        
 \\ \\      / /__| | ___ ___  _ __ ___   ___  | |_ ___  
  \\ \\ /\\ / / _ \\ |/ __/ _ \\| '_ ` _ \\ / _ \\ | __/ _ \\ 
   \\ V  V /  __/ | (_| (_) | | | | | |  __/ | || (_) |
    \\_/\\_/ \\___|_|\\___\\___/|_| |_| |_|\\___|  \\__\\___/ 
        🍰 Welcome to PastryStock API 🍪
    """
    return ascii_art, 200, {'Content-Type': 'text/plain; charset=utf-8'}

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_DEBUG', 'FALSE').upper() == 'TRUE'
    app.run(debug=debug, host='0.0.0.0', port=port)
