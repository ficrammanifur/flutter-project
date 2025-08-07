import 'package:flutter/material.dart';
   import 'signup_screen.dart';
   import 'forgot_password_screen.dart';
   import '../dashboard_screen.dart';
   import '../../services/auth_service.dart';
   import '../../theme/app_theme.dart';

   class LoginScreen extends StatefulWidget {
     const LoginScreen({super.key});

     @override
     State<LoginScreen> createState() => _LoginScreenState();
   }

   class _LoginScreenState extends State<LoginScreen> {
     final _formKey = GlobalKey<FormState>();
     final _emailController = TextEditingController();
     final _passwordController = TextEditingController();
     final AuthService _authService = AuthService();
     bool _isPasswordVisible = false;
     bool _isLoading = false;

     @override
     void dispose() {
       _emailController.dispose();
       _passwordController.dispose();
       super.dispose();
     }

     Future<void> _login() async {
       if (_formKey.currentState!.validate()) {
         setState(() {
           _isLoading = true;
         });

         try {
           bool success = await _authService.login(
             _emailController.text.trim(),
             _passwordController.text,
           );

           if (mounted) {
             setState(() {
               _isLoading = false;
             });

             if (success) {
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => const DashboardScreen()),
               );
             } else {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text('Email atau password salah'),
                   backgroundColor: Colors.red,
                 ),
               );
             }
           }
         } catch (e) {
           if (mounted) {
             setState(() {
               _isLoading = false;
             });
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text('Error: $e'),
                 backgroundColor: Colors.red,
               ),
             );
           }
         }
       }
     }

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: AppTheme.primaryColor,
         body: SafeArea(
           child: SingleChildScrollView(
             padding: const EdgeInsets.all(24.0),
             child: Column(
               children: [
                 const SizedBox(height: 40),
                 Container(
                   width: 100,
                   height: 100,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withValues(alpha: 0.2),
                         blurRadius: 10,
                         offset: const Offset(0, 5),
                       ),
                     ],
                   ),
                   child: const Icon(
                     Icons.bakery_dining,
                     size: 50,
                     color: AppTheme.primaryColor,
                   ),
                 ),
                 const SizedBox(height: 20),
                 const Text(
                   'PastryStock',
                   style: TextStyle(
                     fontSize: 28,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
                 const SizedBox(height: 8),
                 const Text(
                   'Masuk ke akun Anda',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.white70,
                   ),
                 ),
                 const SizedBox(height: 40),
                 Container(
                   padding: const EdgeInsets.all(24),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withValues(alpha: 0.1),
                         blurRadius: 10,
                         offset: const Offset(0, 5),
                       ),
                     ],
                   ),
                   child: Form(
                     key: _formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                         const Text(
                           'Masuk',
                           style: TextStyle(
                             fontSize: 24,
                             fontWeight: FontWeight.bold,
                             color: AppTheme.primaryColor,
                           ),
                           textAlign: TextAlign.center,
                         ),
                         const SizedBox(height: 30),
                         TextFormField(
                           controller: _emailController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                             labelText: 'Email',
                             prefixIcon: const Icon(Icons.email_outlined),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                               borderSide: const BorderSide(
                                 color: AppTheme.primaryColor,
                                 width: 2,
                               ),
                             ),
                           ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Email tidak boleh kosong';
                             }
                             if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                               return 'Format email tidak valid';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 20),
                         TextFormField(
                           controller: _passwordController,
                           obscureText: !_isPasswordVisible,
                           decoration: InputDecoration(
                             labelText: 'Password',
                             prefixIcon: const Icon(Icons.lock_outline),
                             suffixIcon: IconButton(
                               icon: Icon(
                                 _isPasswordVisible
                                     ? Icons.visibility_off
                                     : Icons.visibility,
                               ),
                               onPressed: () {
                                 setState(() {
                                   _isPasswordVisible = !_isPasswordVisible;
                                 });
                               },
                             ),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                               borderSide: const BorderSide(
                                 color: AppTheme.primaryColor,
                                 width: 2,
                               ),
                             ),
                           ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Password tidak boleh kosong';
                             }
                             if (value.length < 6) {
                               return 'Password minimal 6 karakter';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 12),
                         Align(
                           alignment: Alignment.centerRight,
                           child: TextButton(
                             onPressed: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => const ForgotPasswordScreen(),
                                 ),
                               );
                             },
                             child: const Text(
                               'Lupa Password?',
                               style: TextStyle(
                                 color: AppTheme.primaryColor,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 20),
                         ElevatedButton(
                           onPressed: _isLoading ? null : _login,
                           style: ElevatedButton.styleFrom(
                             backgroundColor: AppTheme.primaryColor,
                             foregroundColor: Colors.white,
                             padding: const EdgeInsets.symmetric(vertical: 16),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                             elevation: 3,
                           ),
                           child: _isLoading
                               ? const SizedBox(
                                   height: 20,
                                   width: 20,
                                   child: CircularProgressIndicator(
                                     strokeWidth: 2,
                                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                   ),
                                 )
                               : const Text(
                                   'Masuk',
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(height: 30),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text(
                       'Belum punya akun? ',
                       style: TextStyle(color: Colors.white70),
                     ),
                     TextButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const SignUpScreen(),
                           ),
                         );
                       },
                       child: const Text(
                         'Daftar',
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       );
     }
   }