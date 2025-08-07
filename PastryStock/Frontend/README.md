<h1 align="center"> PastryStock Frontend - Flutter Mobile App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20App-blue?style=for-the-badge&logo=flutter" />
  <img src="https://img.shields.io/badge/Dart-Language-green?style=for-the-badge&logo=dart" />
  <img src="https://img.shields.io/badge/Material-Design-orange?style=for-the-badge&logo=material-design" />
  <img src="https://img.shields.io/badge/ARIMA-Predictions-purple?style=for-the-badge&logo=tensorflow" />
</p>

## 🎯 Overview

PastryStock adalah aplikasi mobile Flutter untuk manajemen stok dan penjualan yang dirancang khusus untuk UMKM bakery/pastry skala kecil-menengah. Aplikasi ini dilengkapi dengan prediksi ARIMA untuk optimalisasi inventory management dan antarmuka yang user-friendly.

## ✨ Fitur Utama

### 📊 Dashboard Interaktif
- **Real-time Monitoring** - Data penjualan dan stok terupdate otomatis
- **Grafik Penjualan** - Visualisasi penjualan 7 hari terakhir
- **Top Menu Items** - 5 menu terlaris dengan performa penjualan
- **Status Stok Visual** - Indikator warna (hijau/kuning/merah) untuk level stok
- **Notifikasi Push** - Alert otomatis untuk stok menipis

### 💰 Manajemen Penjualan
- **Input Penjualan Cepat** - Interface intuitif untuk input penjualan harian
- **5 Menu Utama**:
  - 🧁 Madaline
  - 🧁 Muffin  
  - 🧁 Mini Muffin
  - 🍰 Cheesecake
  - 🍪 Sable Cookies
- **Tracking Historis** - Riwayat penjualan lengkap dengan filter tanggal
- **Kalkulasi Otomatis** - Total penjualan dan revenue dihitung otomatis
- **Export Data** - Export laporan penjualan ke Excel/PDF

### 📦 Manajemen Stok Premium
- **8 Bahan Baku Premium**:
  - 🧀 Keju Premium
  - 🥛 Susu UHT Greenfields
  - ☕ Creamer
  - 🍯 Gula Pasir
  - 🍫 Dark Cokelat
  - 🥛 Yogurt
  - 🍵 Matcha Bubuk
  - 🫖 Earl Grey
- **Update Stok Real-time** - Sinkronisasi otomatis dengan backend
- **Status Visual** - Indikator level stok dengan progress bar
- **History Tracking** - Riwayat penggunaan bahan baku

### 🔮 Prediksi ARIMA Cerdas
- **Prediksi Kebutuhan** - Estimasi kebutuhan stok berdasarkan pola historis
- **Waktu Habis Stok** - Prediksi kapan stok akan habis (dalam hari)
- **Rekomendasi Pemesanan** - Saran jumlah dan waktu optimal untuk restock
- **Model ARIMA** - AutoRegressive Integrated Moving Average untuk akurasi tinggi
- **Confidence Interval** - Tingkat kepercayaan prediksi
- **Trend Analysis** - Analisis tren konsumsi jangka panjang

### ⚙️ Pengaturan Lengkap
- **Mode Demo** - Data dummy untuk testing dan demo
- **Konfigurasi Server** - Setting backend API endpoint
- **Export/Import** - Backup dan restore data
- **Reset Data** - Reset data demo dengan satu klik
- **Theme Settings** - Light/Dark mode support
- **Language Support** - Multi-bahasa (Indonesia/English)

## 🛠️ Teknologi & Arsitektur

### Frontend Stack
| Component | Technology | Version |
|-----------|------------|---------|
| **Framework** | Flutter | 3.7.2+ |
| **Language** | Dart | 3.0+ |
| **UI Framework** | Material Design 3 | Latest |
| **State Management** | Provider + StatefulWidget | Latest |
| **HTTP Client** | http package | 1.1.0+ |
| **Charts** | fl_chart | 0.63.0+ |
| **Local Storage** | shared_preferences | 2.2.0+ |
| **Notifications** | flutter_local_notifications | 15.1.0+ |

### Architecture Pattern
```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
├─────────────────────────────────────────────────────────────┤
│  Screens/Pages  │  Widgets  │  Dialogs  │  Bottom Sheets   │
├─────────────────────────────────────────────────────────────┤
│                     Business Logic Layer                    │
├─────────────────────────────────────────────────────────────┤
│   Services   │   Models   │   Providers   │   Utils        │
├─────────────────────────────────────────────────────────────┤
│                      Data Layer                            │
├─────────────────────────────────────────────────────────────┤
│  API Service │ Local Storage │ Cache Manager │ Preferences │
└─────────────────────────────────────────────────────────────┘
```

## 📱 Persyaratan Sistem

### Development Environment
- **Flutter SDK**: 3.7.2 atau lebih baru
- **Dart SDK**: 3.0 atau lebih baru
- **Android Studio**: 2022.3.1+ atau VS Code dengan Flutter extension
- **Xcode**: 14.0+ (untuk iOS development)
- **Git**: Untuk version control

### Target Devices
- **Android**: 5.0 (API level 21) atau lebih baru
- **iOS**: 11.0 atau lebih baru
- **RAM**: Minimum 2GB, Recommended 4GB+
- **Storage**: 100MB untuk aplikasi + data
- **Network**: Internet connection untuk sinkronisasi data

### Permissions Required
```xml
 Android Permissions 
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

## 🚀 Installation & Setup

### 1. Prerequisites Setup
```bash
# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

### 2. Clone Repository
```bash
git clone https://github.com/yourusername/pastrystock-frontend.git
cd pastrystock-frontend
```

### 3. Install Dependencies
```bash
# Get Flutter packages
flutter pub get

# For iOS (if developing for iOS)
cd ios && pod install && cd ..
```

### 4. Configuration Setup

#### Create \`lib/config/app_config.dart\`:
```dart
class AppConfig {
  static const String baseUrl = 'http://localhost:5000/api';
  static const String appName = 'PastryStock';
  static const String version = '1.0.0';
  static const bool enableDemo = true;
  static const int requestTimeout = 30; // seconds
  
  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String salesEndpoint = '/sales';
  static const String ingredientsEndpoint = '/ingredients';
  static const String predictionsEndpoint = '/predictions';
}
```

#### Update \`android/app/src/main/AndroidManifest.xml\`:
```xml
<application
    android:label="PastryStock"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher"
    android:usesCleartextTraffic="true">
    
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
        
        <meta-data
          android:name="io.flutter.embedding.android.NormalTheme"
          android:resource="@style/NormalTheme" />
          
        <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
</application>
```

### 5. Run Application
```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Run on specific device
flutter devices
flutter run -d <device_id>
```

## 📂 Project Structure

```
lib/
├── main.dart                    # Entry point
├── config/
│   ├── app_config.dart         # App configuration
│   ├── theme_config.dart       # Theme settings
│   └── route_config.dart       # Route definitions
├── screens/
│   ├── splash_screen.dart      # Splash screen
│   ├── auth/
│   │   ├── login_screen.dart   # Login page
│   │   └── register_screen.dart # Registration page
│   ├── dashboard/
│   │   └── dashboard_screen.dart # Main dashboard
│   ├── sales/
│   │   ├── sales_screen.dart   # Sales management
│   │   └── sales_history_screen.dart # Sales history
│   ├── inventory/
│   │   ├── inventory_screen.dart # Stock management
│   │   └── ingredient_detail_screen.dart # Ingredient details
│   ├── predictions/
│   │   ├── predictions_screen.dart # ARIMA predictions
│   │   └── prediction_detail_screen.dart # Detailed predictions
│   └── settings/
│       └── settings_screen.dart # App settings
├── widgets/
│   ├── common/
│   │   ├── custom_app_bar.dart # Reusable app bar
│   │   ├── loading_widget.dart # Loading indicators
│   │   ├── error_widget.dart   # Error displays
│   │   └── empty_state_widget.dart # Empty state
│   ├── dashboard/
│   │   ├── sales_chart_widget.dart # Sales chart
│   │   ├── stock_status_widget.dart # Stock status
│   │   └── quick_actions_widget.dart # Quick action buttons
│   ├── sales/
│   │   ├── sales_form_widget.dart # Sales input form
│   │   └── sales_item_widget.dart # Sales list item
│   ├── inventory/
│   │   ├── ingredient_card_widget.dart # Ingredient card
│   │   └── stock_level_widget.dart # Stock level indicator
│   └── predictions/
│       ├── prediction_chart_widget.dart # Prediction chart
│       └── recommendation_widget.dart # Recommendations
├── models/
│   ├── user_model.dart         # User data model
│   ├── sales_model.dart        # Sales data model
│   ├── ingredient_model.dart   # Ingredient data model
│   ├── prediction_model.dart   # Prediction data model
│   └── api_response_model.dart # API response wrapper
├── services/
│   ├── api_service.dart        # HTTP API service
│   ├── auth_service.dart       # Authentication service
│   ├── sales_service.dart      # Sales operations
│   ├── inventory_service.dart  # Inventory operations
│   ├── prediction_service.dart # Prediction operations
│   ├── local_storage_service.dart # Local data storage
│   └── notification_service.dart # Push notifications
├── providers/
│   ├── auth_provider.dart      # Authentication state
│   ├── sales_provider.dart     # Sales state management
│   ├── inventory_provider.dart # Inventory state management
│   └── theme_provider.dart     # Theme state management
├── utils/
│   ├── constants.dart          # App constants
│   ├── helpers.dart           # Helper functions
│   ├── validators.dart        # Input validators
│   ├── formatters.dart        # Data formatters
│   └── extensions.dart        # Dart extensions
└── assets/
    ├── images/
    │   ├── logo.png           # App logo
    │   ├── splash_bg.png      # Splash background
    │   └── icons/             # Custom icons
    ├── fonts/                 # Custom fonts
    └── data/
        └── demo_data.json     # Demo data for testing
```

## 🎨 UI/UX Design System

### Color Palette
```dart
class AppColors {
  // Primary Colors - Warm Bakery Theme
  static const Color primary = Color(0xFF8B4513);        // Saddle Brown
  static const Color primaryLight = Color(0xFFD2691E);   // Chocolate
  static const Color primaryDark = Color(0xFF654321);    // Dark Brown
  
  // Secondary Colors
  static const Color secondary = Color(0xFFDEB887);      // Burlywood
  static const Color secondaryLight = Color(0xFFF5DEB3); // Wheat
  static const Color secondaryDark = Color(0xFFCD853F);  // Peru
  
  // Background Colors
  static const Color background = Color(0xFFF5F5DC);     // Beige
  static const Color surface = Color(0xFFFFFFFF);        // White
  static const Color surfaceDark = Color(0xFF2C2C2C);    // Dark Surface
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);        // Green
  static const Color warning = Color(0xFFFF9800);        // Orange
  static const Color error = Color(0xFFF44336);          // Red
  static const Color info = Color(0xFF2196F3);           // Blue
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);    // Dark Gray
  static const Color textSecondary = Color(0xFF757575);  // Medium Gray
  static const Color textHint = Color(0xFFBDBDBD);       // Light Gray
}
```

### Typography
```dart
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
```

### Component Themes
```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(0xFF8B4513, {
      50: Color(0xFFF3E5AB),
      100: Color(0xFFE6CC85),
      200: Color(0xFFD9B366),
      300: Color(0xFFCC9A47),
      400: Color(0xFFBF8128),
      500: Color(0xFF8B4513),
      600: Color(0xFF7A3C11),
      700: Color(0xFF69330F),
      800: Color(0xFF582A0D),
      900: Color(0xFF47210B),
    }),
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
```

## 📊 State Management

### Provider Pattern Implementation
```dart
// Sales Provider Example
class SalesProvider with ChangeNotifier {
  List<Sale> _sales = [];
  bool _isLoading = false;
  String? _error;
  
  List<Sale> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchSales() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService.getSales();
      _sales = response.data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> addSale(Sale sale) async {
    try {
      final response = await ApiService.addSale(sale);
      _sales.insert(0, response.data);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
```

### Provider Setup in main.dart
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

## 🔌 API Integration

### API Service Implementation
```dart
class ApiService {
  static const String baseUrl = AppConfig.baseUrl;
  static final http.Client _client = http.Client();
  
  static Future<ApiResponse<T>> _makeRequest<T>(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }
      
      // Add auth token if available
      final token = await AuthService.getToken();
      if (token != null) {
        defaultHeaders['Authorization'] = 'Bearer $token';
      }
      
      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(url, headers: defaultHeaders);
          break;
        case 'POST':
          response = await _client.post(
            url,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'PUT':
          response = await _client.put(
            url,
            headers: defaultHeaders,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(url, headers: defaultHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
      
      final responseData = json.decode(response.body);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.success(
          data: fromJson != null ? fromJson(responseData['data']) : responseData['data'],
          message: responseData['message'],
        );
      } else {
        return ApiResponse<T>.error(
          message: responseData['message'] ?? 'Unknown error occurred',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<T>.error(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
  
  // Sales API methods
  static Future<ApiResponse<List<Sale>>> getSales() async {
    return _makeRequest<List<Sale>>(
      'GET',
      '/sales',
      fromJson: (data) => (data as List).map((item) => Sale.fromJson(item)).toList(),
    );
  }
  
  static Future<ApiResponse<Sale>> addSale(Sale sale) async {
    return _makeRequest<Sale>(
      'POST',
      '/sales',
      body: sale.toJson(),
      fromJson: (data) => Sale.fromJson(data),
    );
  }
  
  // Ingredients API methods
  static Future<ApiResponse<List<Ingredient>>> getIngredients() async {
    return _makeRequest<List<Ingredient>>(
      'GET',
      '/ingredients',
      fromJson: (data) => (data as List).map((item) => Ingredient.fromJson(item)).toList(),
    );
  }
  
  // Predictions API methods
  static Future<ApiResponse<List<Prediction>>> getPredictions() async {
    return _makeRequest<List<Prediction>>(
      'GET',
      '/predictions',
      fromJson: (data) => (data as List).map((item) => Prediction.fromJson(item)).toList(),
    );
  }
}
```

## 📊 ARIMA Prediction Implementation

### Prediction Model
```dart
class Prediction {
  final String ingredientId;
  final String ingredientName;
  final String unit;
  final double currentStock;
  final List<double> predictedConsumption;
  final List<double> predictedStock;
  final int daysUntilEmpty;
  final double recommendedOrder;
  final double confidence;
  final Map<String, dynamic> modelParams;
  final DateTime predictionDate;
  
  Prediction({
    required this.ingredientId,
    required this.ingredientName,
    required this.unit,
    required this.currentStock,
    required this.predictedConsumption,
    required this.predictedStock,
    required this.daysUntilEmpty,
    required this.recommendedOrder,
    required this.confidence,
    required this.modelParams,
    required this.predictionDate,
  });
  
  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      ingredientId: json['ingredientId'],
      ingredientName: json['ingredientName'],
      unit: json['unit'],
      currentStock: json['currentStock'].toDouble(),
      predictedConsumption: List<double>.from(json['predictedConsumption']),
      predictedStock: List<double>.from(json['predictedStock']),
      daysUntilEmpty: json['daysUntilEmpty'],
      recommendedOrder: json['recommendedOrder'].toDouble(),
      confidence: json['confidence'].toDouble(),
      modelParams: json['modelParams'],
      predictionDate: DateTime.parse(json['predictionDate']),
    );
  }
}
```

### Prediction Chart Widget
```dart
class PredictionChartWidget extends StatelessWidget {
  final Prediction prediction;
  
  const PredictionChartWidget({Key? key, required this.prediction}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediksi Stok - ${prediction.ingredientName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}${prediction.unit}');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Hari ${value.toInt()}');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    // Current stock line
                    LineChartBarData(
                      spots: _generateCurrentStockSpots(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                    // Predicted stock line
                    LineChartBarData(
                      spots: _generatePredictedStockSpots(),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildPredictionSummary(context),
          ],
        ),
      ),
    );
  }
  
  List<FlSpot> _generateCurrentStockSpots() {
    // Generate spots for current stock visualization
    return List.generate(7, (index) {
      return FlSpot(index.toDouble(), prediction.currentStock);
    });
  }
  
  List<FlSpot> _generatePredictedStockSpots() {
    // Generate spots for predicted stock
    return List.generate(prediction.predictedStock.length, (index) {
      return FlSpot(index.toDouble(), prediction.predictedStock[index]);
    });
  }
  
  Widget _buildPredictionSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Stok akan habis dalam:'),
            Text(
              '${prediction.daysUntilEmpty} hari',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: prediction.daysUntilEmpty <= 3 ? Colors.red : Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rekomendasi pemesanan:'),
            Text(
              '${prediction.recommendedOrder.toInt()} ${prediction.unit}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tingkat kepercayaan:'),
            Text(
              '${(prediction.confidence * 100).toInt()}%',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
```

## 🧪 Testing

### Unit Testing
```dart
// test/models/sales_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pastrystock/models/sales_model.dart';

void main() {
  group('Sales Model Tests', () {
    test('should create Sale from JSON correctly', () {
      final json = {
        'id': 'sale123',
        'menuName': 'Muffin',
        'quantity': 10,
        'pricePerItem': 20000,
        'totalAmount': 200000,
        'date': '2025-01-20T10:30:00Z',
      };
      
      final sale = Sale.fromJson(json);
      
      expect(sale.id, 'sale123');
      expect(sale.menuName, 'Muffin');
      expect(sale.quantity, 10);
      expect(sale.pricePerItem, 20000);
      expect(sale.totalAmount, 200000);
    });
    
    test('should convert Sale to JSON correctly', () {
      final sale = Sale(
        id: 'sale123',
        menuName: 'Muffin',
        quantity: 10,
        pricePerItem: 20000,
        totalAmount: 200000,
        date: DateTime.parse('2025-01-20T10:30:00Z'),
      );
      
      final json = sale.toJson();
      
      expect(json['id'], 'sale123');
      expect(json['menuName'], 'Muffin');
      expect(json['quantity'], 10);
    });
  });
}
```

### Widget Testing
```dart
// test/widgets/sales_form_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pastrystock/widgets/sales/sales_form_widget.dart';

void main() {
  group('Sales Form Widget Tests', () {
    testWidgets('should display all menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalesFormWidget(
              onSubmit: (sale) {},
            ),
          ),
        ),
      );
      
      expect(find.text('Muffin'), findsOneWidget);
      expect(find.text('Croissant'), findsOneWidget);
      expect(find.text('Cheesecake'), findsOneWidget);
    });
    
    testWidgets('should validate quantity input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalesFormWidget(
              onSubmit: (sale) {},
            ),
          ),
        ),
      );
      
      // Enter invalid quantity
      await tester.enterText(find.byType(TextFormField).first, '-1');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      expect(find.text('Quantity must be greater than 0'), findsOneWidget);
    });
  });
}
```

### Integration Testing
```dart
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pastrystock/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('App Integration Tests', () {
    testWidgets('complete sales flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to sales screen
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      
      // Add a sale
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      
      // Fill form
      await tester.enterText(find.byType(TextFormField).first, '5');
      await tester.tap(find.text('Muffin'));
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();
      
      // Verify sale was added
      expect(find.text('Penjualan berhasil ditambahkan'), findsOneWidget);
    });
  });
}
```

### Run Tests
```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run tests with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📱 Build & Deployment

### Android Build
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Build
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Build for App Store
flutter build ipa --release
```

### Build Configuration
```yaml
# android/app/build.gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        applicationId "com.pastrystock.app"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        
        multiDexEnabled true
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

## 🔧 Performance Optimization

### Image Optimization
```dart
// Use cached network images
import 'package:cached_network_image.dart';

Widget buildOptimizedImage(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
    memCacheWidth: 300,
    memCacheHeight: 300,
  );
}
```

### List Performance
```dart
// Use ListView.builder for large lists
Widget buildOptimizedList(List<Sale> sales) {
  return ListView.builder(
    itemCount: sales.length,
    itemBuilder: (context, index) {
      return SaleItemWidget(sale: sales[index]);
    },
  );
}
```

### State Management Optimization
```dart
// Use Selector for specific state updates
class SalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SalesProvider, bool>(
      selector: (context, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return CircularProgressIndicator();
        }
        return SalesListWidget();
      },
    );
  }
}
```

## 🔒 Security Best Practices

### Secure Storage
```dart
import 'package:flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
```

### Input Validation
```dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
  
  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Quantity must be greater than 0';
    }
    return null;
  }
}
```

## 🐛 Troubleshooting

### Common Issues

#### Build Errors
```bash
# Clean build cache
flutter clean
flutter pub get

# Reset iOS pods
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..

# Fix Android build issues
cd android && ./gradlew clean && cd ..
```

#### Network Issues
```dart
// Add network security config for Android
// android/app/src/main/res/xml/network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">localhost</domain>
        <domain includeSubdomains="true">10.0.2.2</domain>
    </domain-config>
</network-security-config>
```

#### Performance Issues
```dart
// Enable performance overlay
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false; // Set to true for debugging
  runApp(MyApp());
}
```

## 📈 Analytics & Monitoring

### Crash Reporting
```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set up Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  runApp(MyApp());
}
```

### Performance Monitoring
```dart
import 'package:firebase_performance/firebase_performance.dart';

class ApiService {
  static Future<void> trackApiCall(String endpoint) async {
    final trace = FirebasePerformance.instance.newTrace('api_call_$endpoint');
    await trace.start();
    
    try {
      // Make API call
      await _makeApiCall(endpoint);
    } finally {
      await trace.stop();
    }
  }
}
```

## 🤝 Contributing

### Development Guidelines
1. Follow Flutter/Dart style guide
2. Write comprehensive tests
3. Update documentation
4. Use meaningful commit messages
5. Create feature branches

### Code Review Checklist
- [ ] Code follows style guidelines
- [ ] Tests are included and passing
- [ ] Documentation is updated
- [ ] Performance impact is considered
- [ ] Security best practices are followed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Material Design** for UI/UX guidelines
- **Firebase** for backend services
- **Chart Libraries** for data visualization
- **Open Source Community** for various packages

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/yourusername/pastrystock-frontend/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/pastrystock-frontend/discussions)
- **Email**: support@pastrystock.com
- **Documentation**: [Flutter Docs](https://docs.flutter.dev/)

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

Made with ❤️ using Flutter

<p><a href="#top">⬆ Back on Top</a></p>

</div>
