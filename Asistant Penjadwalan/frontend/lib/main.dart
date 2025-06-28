import 'package:flutter/material.dart';
import 'pages/auth/signin_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/auth/forgot_password_page.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/chat/chat_page.dart';
import 'pages/jadwal/jadwal_hari_ini_page.dart';
import 'pages//jadwal/input_jadwal_page.dart';
import 'pages/jadwal/lihat_jadwal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asisten Jadwal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF667EEA),
          primary: const Color(0xFF667EEA),
          secondary: const Color(0xFF764BA2),
          tertiary: const Color(0xFFF093FB),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF667EEA),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF667EEA),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('userId') && args.containsKey('userName')) {
            return HomePage(
              userId: args['userId'] as int,
              userName: args['userName'] as String,
            );
          }
          // Fallback jika parameter tidak lengkap
          return const SignInPage();
        },
        '/jadwal-hari-ini': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('userId')) {
            return JadwalHariIniPage(userId: args['userId'] as int);
          }
          return const SignInPage();
        },
        '/input-jadwal': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('userId')) {
            return InputJadwalPage(userId: args['userId'] as int);
          }
          return const SignInPage();
        },
        '/lihat-jadwal': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('userId')) {
            return LihatJadwalPage(userId: args['userId'] as int);
          }
          return const SignInPage();
        },
        '/chat': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('userId')) {
            return ChatPage(userId: args['userId'] as int);
          }
          return const SignInPage();
        },
      },
      onGenerateRoute: (settings) {
        // Fallback untuk route yang tidak terdaftar
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
        );
      },
    );
  }
}