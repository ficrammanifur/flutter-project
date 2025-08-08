# 🧘 Pilates Member - Flutter Frontend

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.7+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Material-Design%203-757575?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design" />
  <img src="https://img.shields.io/badge/Android-API%2021+-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
  <img src="https://img.shields.io/badge/iOS-11.0+-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS" />
</p>

## 🎯 Overview

A beautiful and intuitive Flutter mobile application for Pilates studio members to manage their memberships, book classes, and track their fitness journey. Built with Material Design 3 and featuring both online and offline functionality.

## ✨ Key Features

### 🔐 Authentication & User Management
- **Secure Login/Register** - JWT-based authentication with validation
- **Demo Credentials** - Pre-configured test accounts for easy testing
- **Profile Management** - Complete user profile with photo upload
- **Offline Mode** - Fully functional with mock data when backend unavailable
- **Auto-Login** - Remember user sessions with secure token storage

### 💳 Membership Management
- **Package Browsing** - View all available membership packages
- **WhatsApp Integration** - Seamless payment via WhatsApp Business
- **Membership Status** - Real-time tracking of active memberships
- **Class Credits** - Monitor remaining classes and expiry dates
- **Renewal Notifications** - Automated alerts for membership renewal

### 📅 Class Booking System
- **Available Classes** - Browse classes by date, instructor, and level
- **Real-time Booking** - Instant class booking with capacity management
- **Booking History** - Track past and upcoming classes
- **Cancellation** - Easy class cancellation with refund policies
- **Waitlist Management** - Join waitlists for full classes

### 🎨 Modern UI/UX
- **Material Design 3** - Latest design system with dynamic theming
- **Responsive Design** - Optimized for all screen sizes and orientations
- **Custom Animations** - Smooth transitions and micro-interactions
- **Dark/Light Theme** - Automatic theme switching based on system preferences
- **Accessibility** - Full accessibility support with screen readers

## 🛠️ Tech Stack

| Component | Technology | Version |
|-----------|------------|---------|
| **Framework** | Flutter | 3.7.2+ |
| **Language** | Dart | 3.0+ |
| **UI Framework** | Material Design 3 | Latest |
| **State Management** | Provider | 6.0+ |
| **HTTP Client** | http | 1.1+ |
| **Local Storage** | shared_preferences | 2.2+ |
| **URL Launcher** | url_launcher | 6.1+ |
| **Image Picker** | image_picker | 1.0+ |

## 📋 Requirements

### Development Environment
- **Flutter SDK**: 3.7.2 or higher
- **Dart SDK**: 3.0 or higher
- **Android Studio**: 2022.3.1+ or VS Code with Flutter extension
- **Xcode**: 14.0+ (for iOS development)

### Target Devices
- **Android**: 5.0 (API level 21) or higher
- **iOS**: 11.0 or higher
- **RAM**: Minimum 2GB, Recommended 4GB+
- **Storage**: 100MB for app installation

## 🚀 Installation & Setup

### 1. Prerequisites
```bash
# Verify Flutter installation
flutter doctor

# Ensure all dependencies are satisfied
flutter doctor --android-licenses
```

### 2. Create Flutter Project
```bash
# Create new Flutter project
flutter create pilates_member
cd pilates_member
```

### 3. Update Dependencies
```plaintext
Replace your `pubspec.yaml` with:
name: pilates_member
description: A beautiful Pilates studio membership app
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 &lt;4.0.0'
  flutter: ">=3.7.0"

dependencies:
  flutter:
    sdk: flutter
  
  # UI & Navigation
  cupertino_icons: ^1.0.2
  
  # State Management
  provider: ^6.0.5
  
  # HTTP & API
  http: ^1.1.0
  
  # Local Storage
  shared_preferences: ^2.2.0
  
  # Utilities
  url_launcher: ^6.1.12
  image_picker: ^1.0.4
  
  # Date & Time
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
  
  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf
        - asset: fonts/Roboto-Bold.ttf
          weight: 700
```

### 4. Create Project Structure

```shellscript
# Create directory structure
mkdir -p lib/{models,services,screens,widgets,utils,theme}
mkdir -p assets/{images,icons}
mkdir -p fonts
```

### 5. Add Assets

```shellscript
# Create placeholder logo (or add your own)
# Add logo.png to assets/images/
# Add any custom fonts to fonts/
```

### 6. Install Dependencies

```shellscript
flutter pub get
```

### 7. Run the Application

```shellscript
# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release
```

## Project Structure

```plaintext
lib/
├── main.dart                     # App entry point
├── routes.dart                   # Navigation configuration
├── 
├── theme/
│   ├── app_theme.dart           # Material Design 3 theme
│   ├── colors.dart              # Color palette
│   └── text_styles.dart         # Typography styles
│
├── models/
│   ├── user.dart                # User data model
│   ├── membership.dart          # Membership model
│   ├── class_model.dart         # Class data model
│   ├── booking.dart             # Booking model
│   └── package.dart             # Package model
│
├── services/
│   ├── auth_service.dart        # Authentication service
│   ├── api_service.dart         # HTTP API service
│   ├── data_service.dart        # Data management
│   ├── storage_service.dart     # Local storage
│   └── whatsapp_service.dart    # WhatsApp integration
│
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart   # Animated splash screen
│   ├── auth/
│   │   ├── login_screen.dart    # Login interface
│   │   └── register_screen.dart # Registration form
│   ├── dashboard/
│   │   ├── dashboard_screen.dart # Main dashboard
│   │   ├── home_tab.dart        # Home tab content
│   │   ├── packages_tab.dart    # Packages tab
│   │   └── classes_tab.dart     # My classes tab
│   ├── profile/
│   │   ├── profile_screen.dart  # User profile
│   │   └── edit_profile_screen.dart # Edit profile
│   ├── classes/
│   │   ├── class_list_screen.dart # Available classes
│   │   ├── class_detail_screen.dart # Class details
│   │   └── booking_screen.dart  # Booking interface
│   └── membership/
│       ├── packages_screen.dart # Membership packages
│       └── purchase_screen.dart # Package purchase
│
├── widgets/
│   ├── common/
│   │   ├── custom_button.dart   # Reusable button
│   │   ├── custom_card.dart     # Custom card widget
│   │   ├── loading_widget.dart  # Loading indicators
│   │   └── error_widget.dart    # Error displays
│   ├── auth/
│   │   ├── login_form.dart      # Login form widget
│   │   └── register_form.dart   # Registration form
│   ├── dashboard/
│   │   ├── welcome_card.dart    # Welcome card
│   │   ├── membership_status.dart # Membership status
│   │   └── quick_actions.dart   # Quick action buttons
│   └── classes/
│       ├── class_card.dart      # Class card widget
│       └── booking_card.dart    # Booking card
│
└── utils/
    ├── constants.dart           # App constants
    ├── helpers.dart             # Helper functions
    ├── validators.dart          # Input validators
    ├── formatters.dart          # Data formatters
    └── extensions.dart          # Dart extensions
```

## Design System

### Color Palette

```plaintext
class AppColors {
  // Primary Colors - Pilates Theme
  static const Color primary = Color(0xFF6B46C1);        // Purple
  static const Color primaryLight = Color(0xFF8B5CF6);   // Light Purple
  static const Color primaryDark = Color(0xFF553C9A);    // Dark Purple
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981);      // Emerald
  static const Color secondaryLight = Color(0xFF34D399); // Light Emerald
  static const Color secondaryDark = Color(0xFF059669);  // Dark Emerald
  
  // Background Colors
  static const Color background = Color(0xFFF8FAFC);     // Light Gray
  static const Color surface = Color(0xFFFFFFFF);        // White
  static const Color surfaceDark = Color(0xFF1E293B);    // Dark Surface
  
  // Status Colors
  static const Color success = Color(0xFF10B981);        // Green
  static const Color warning = Color(0xFFF59E0B);        // Amber
  static const Color error = Color(0xFFEF4444);          // Red
  static const Color info = Color(0xFF3B82F6);           // Blue
}
```

### Typography

```plaintext
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );
}
```

### Component Themes

```plaintext
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    cardTheme: const CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}
```

## Authentication Flow

### Demo Credentials

```plaintext
// Available demo accounts for testing
final demoUsers = [
  {
    'name': 'John Doe',
    'email': 'john@example.com',
    'password': 'password123',
    'membership': 'Premium Package'
  },
  {
    'name': 'Jane Smith',
    'email': 'jane@example.com',
    'password': 'password123',
    'membership': 'Basic Package'
  },
  {
    'name': 'Admin User',
    'email': 'admin@pilatesstudio.com',
    'password': 'admin123',
    'membership': 'Unlimited Package'
  }
];
```

### Authentication Service

```plaintext
class AuthService extends ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLoading = false;
  
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Try backend first
      final response = await ApiService.login(email, password);
      if (response.success) {
        _currentUser = response.user;
        _token = response.token;
        await _saveUserData();
        return true;
      }
    } catch (e) {
      // Fallback to mock authentication
      final mockUser = _authenticateWithMockData(email, password);
      if (mockUser != null) {
        _currentUser = mockUser;
        await _saveUserData();
        return true;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    
    return false;
  }
}
```

## Screen Implementations

### Splash Screen

```plaintext
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _controller.forward();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final isLoggedIn = await authService.checkAuthStatus();
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(
        isLoggedIn ? '/dashboard' : '/login',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.self_improvement,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Pilates Studio',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Transform Your Body & Mind',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### Dashboard Screen

```plaintext
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _tabs = [
    HomeTab(),
    PackagesTab(),
    ClassesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_membership_outlined),
            selectedIcon: Icon(Icons.card_membership),
            label: 'Packages',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'My Classes',
          ),
        ],
      ),
    );
  }
}
```

## API Integration

### API Service

```plaintext
class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api'; // Android Emulator
  static const Duration timeout = Duration(seconds: 10);
  
  static Future<ApiResponse<User>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(timeout);
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 && data['success']) {
        return ApiResponse.success(
          data: User.fromJson(data['data']['user']),
          token: data['data']['access_token'],
        );
      } else {
        return ApiResponse.error(message: data['message'] ?? 'Login failed');
      }
    } catch (e) {
      return ApiResponse.error(message: 'Network error: ${e.toString()}');
    }
  }
  
  static Future<ApiResponse<List<Package>>> getPackages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/packages'),
        headers: await _getHeaders(),
      ).timeout(timeout);
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 && data['success']) {
        final packages = (data['data'] as List)
            .map((item) => Package.fromJson(item))
            .toList();
        return ApiResponse.success(data: packages);
      } else {
        return ApiResponse.error(message: data['message'] ?? 'Failed to load packages');
      }
    } catch (e) {
      return ApiResponse.error(message: 'Network error: ${e.toString()}');
    }
  }
  
  static Future<Map<String, String>> _getHeaders() async {
    final token = await StorageService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
```

### Offline Fallback

```plaintext
class DataService extends ChangeNotifier {
  bool _isOnline = true;
  
  bool get isOnline => _isOnline;
  
  Future<List<Package>> getPackages() async {
    try {
      final response = await ApiService.getPackages();
      if (response.success) {
        _isOnline = true;
        notifyListeners();
        return response.data!;
      }
    } catch (e) {
      _isOnline = false;
      notifyListeners();
    }
    
    // Fallback to mock data
    return _getMockPackages();
  }
  
  List<Package> _getMockPackages() {
    return [
      Package(
        id: '1',
        name: 'Trial Package',
        description: 'Perfect for first-time visitors',
        price: 25.00,
        classesIncluded: 1,
        validityDays: 7,
        features: ['1 group class', 'Basic equipment access'],
      ),
      Package(
        id: '2',
        name: 'Basic Package',
        description: 'Great for beginners',
        price: 80.00,
        classesIncluded: 4,
        validityDays: 30,
        features: ['4 group classes', 'Equipment access', 'Online booking'],
      ),
      // ... more packages
    ];
  }
}
```

## WhatsApp Payment Integration

### WhatsApp Service

```plaintext
class WhatsAppService {
  static const String businessNumber = '+1234567890';
  static const String businessName = 'Pilates Studio';
  
  static Future<void> sendPaymentMessage({
    required Package package,
    required User user,
  }) async {
    final message = _generatePaymentMessage(package, user);
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = 'https://wa.me/$businessNumber?text=$encodedMessage';
    
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
  
  static String _generatePaymentMessage(Package package, User user) {
    return '''
🧘 *Pilates Studio Membership Purchase*

*Customer Details:*
Name: ${user.name}
Email: ${user.email}

*Package Details:*
Package: ${package.name}
Price: \$${package.price.toStringAsFixed(2)}
Classes: ${package.classesIncluded == -1 ? 'Unlimited' : package.classesIncluded}
Validity: ${package.validityDays} days

*Features:*
${package.features.map((f) => '• $f').join('\n')}

I would like to purchase this membership package. Please confirm payment details.

Thank you! 🙏
    ''';
  }
}
```

## Testing

### Unit Tests

```plaintext
// test/services/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_member/services/auth_service.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;
    
    setUp(() {
      authService = AuthService();
    });
    
    test('should authenticate with valid demo credentials', () async {
      final result = await authService.login('john@example.com', 'password123');
      
      expect(result, true);
      expect(authService.isAuthenticated, true);
      expect(authService.currentUser?.email, 'john@example.com');
    });
    
    test('should reject invalid credentials', () async {
      final result = await authService.login('invalid@example.com', 'wrongpassword');
      
      expect(result, false);
      expect(authService.isAuthenticated, false);
    });
  });
}
```

### Widget Tests

```plaintext
// test/widgets/login_form_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_member/widgets/auth/login_form.dart';

void main() {
  group('LoginForm Widget Tests', () {
    testWidgets('should display email and password fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginForm(onSubmit: (email, password) {}),
          ),
        ),
      );
      
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });
    
    testWidgets('should validate email format', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginForm(onSubmit: (email, password) {}),
          ),
        ),
      );
      
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });
  });
}
```

### Integration Tests

```plaintext
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pilates_member/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('App Integration Tests', () {
    testWidgets('complete login flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Wait for splash screen
      await tester.pumpAndSettle(const Duration(seconds: 4));
      
      // Should be on login screen
      expect(find.text('Welcome Back'), findsOneWidget);
      
      // Enter credentials
      await tester.enterText(find.byType(TextFormField).first, 'john@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      
      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      
      // Should navigate to dashboard
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
```

## Build & Deployment

### Android Build

```shellscript
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

### iOS Build

```shellscript
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
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.pilatesstudio.member"
        minSdkVersion 21
        targetSdkVersion 34
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

## Performance Optimization

### Image Optimization

```plaintext
// Optimized image loading
Widget buildOptimizedImage(String imageUrl) {
  return Image.network(
    imageUrl,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const CircularProgressIndicator();
    },
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.error);
    },
    cacheWidth: 300,
    cacheHeight: 300,
  );
}
```

### List Performance

```plaintext
// Optimized list rendering
Widget buildOptimizedList(List<ClassModel> classes) {
  return ListView.builder(
    itemCount: classes.length,
    itemExtent: 120, // Fixed height for better performance
    itemBuilder: (context, index) {
      return ClassCard(class: classes[index]);
    },
  );
}
```

### State Management Optimization

```plaintext
// Use Selector for specific updates
class ClassesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<DataService, List<ClassModel>>(
      selector: (context, service) => service.availableClasses,
      builder: (context, classes, child) {
        return ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return ClassCard(class: classes[index]);
          },
        );
      },
    );
  }
}
```

## Security Best Practices

### Secure Storage

```plaintext
class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
```

### Input Validation

```plaintext
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length &lt; 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
  
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[\d\s-()]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
```

## Troubleshooting

### Common Issues

#### Build Errors

```shellscript
# Clean build cache
flutter clean
flutter pub get

# Reset iOS pods
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..

# Fix Android build issues
cd android && ./gradlew clean && cd ..
```

#### Network Issues

```plaintext
// Add network security config for Android
// android/app/src/main/res/xml/network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">10.0.2.2</domain>
        <domain includeSubdomains="true">localhost</domain>
    </domain-config>
</network-security-config>
```

#### State Management Issues

```plaintext
// Proper provider usage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DataService()),
      ],
      child: MaterialApp(
        title: 'Pilates Member',
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
```

## Analytics & Monitoring

### Performance Monitoring

```plaintext
// Add performance monitoring
import 'dart:developer' as developer;

class PerformanceMonitor {
  static void trackScreenView(String screenName) {
    developer.log('Screen View: $screenName', name: 'Analytics');
  }
  
  static void trackEvent(String event, Map<String, dynamic> parameters) {
    developer.log('Event: $event', name: 'Analytics');
    developer.log('Parameters: $parameters', name: 'Analytics');
  }
}
```

### Error Tracking

```plaintext
// Global error handling
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    developer.log(
      'Flutter Error: ${details.exception}',
      name: 'Error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };
  
  runApp(MyApp());
}
```

## Contributing

### Development Guidelines

1. Follow Flutter/Dart style guide
2. Write comprehensive tests
3. Update documentation
4. Use meaningful commit messages
5. Create feature branches


### Code Review Checklist

- Code follows style guidelines
- Tests are included and passing
- Documentation is updated
- Performance impact is considered
- Accessibility is maintained


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Flutter Team** for the amazing framework
- **Material Design** for UI/UX guidelines
- **Provider Package** for state management
- **Open Source Community** for various packages


## Support & Contact

- **Issues**: [GitHub Issues](https://github.com/yourusername/pilates-member-frontend/issues)
- **Email**: [support@pilatesstudio.com](mailto:support@pilatesstudio.com)
- **Documentation**: [Flutter Docs](https://docs.flutter.dev/)


---

<div>**⭐ Star this repository if you found it helpful!**

Made with ❤️ using Flutter

</div>
```plaintext
<Actions>
  <Action name="Create Widget Library" description="Create a comprehensive widget library with reusable components" />
  <Action name="Add Animations Package" description="Implement advanced animations and transitions throughout the app" />
  <Action name="Setup Firebase Integration" description="Add Firebase Analytics, Crashlytics, and Push Notifications" />
  <Action name="Create Design System" description="Build a complete design system with tokens and component documentation" />
  <Action name="Add Accessibility Features" description="Implement comprehensive accessibility features and screen reader support" />
</Actions>
```
