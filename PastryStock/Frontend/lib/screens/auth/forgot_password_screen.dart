import 'package:flutter/material.dart';
   import '../../services/auth_service.dart';
   import '../../theme/app_theme.dart';

   class ForgotPasswordScreen extends StatefulWidget {
     const ForgotPasswordScreen({super.key});

     @override
     State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
   }

   class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
     final _formKey = GlobalKey<FormState>();
     final _emailController = TextEditingController();
     final AuthService _authService = AuthService();
     bool _isLoading = false;
     bool _emailSent = false;

     @override
     void dispose() {
       _emailController.dispose();
       super.dispose();
     }

     Future<void> _resetPassword() async {
       if (_formKey.currentState!.validate()) {
         setState(() {
           _isLoading = true;
         });

         try {
           bool success = await _authService.resetPassword(_emailController.text.trim());

           if (mounted) {
             setState(() {
               _isLoading = false;
               _emailSent = success;
             });

             if (!success) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text('Gagal mengirim email reset. Silakan coba lagi.'),
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
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
           leading: IconButton(
             icon: const Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () => Navigator.pop(context),
           ),
         ),
         body: SafeArea(
           child: SingleChildScrollView(
             padding: const EdgeInsets.all(24.0),
             child: Column(
               children: [
                 const SizedBox(height: 20),
                 Container(
                   width: 80,
                   height: 80,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(16),
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
                     size: 40,
                     color: AppTheme.primaryColor,
                   ),
                 ),
                 const SizedBox(height: 16),
                 const Text(
                   'PastryStock',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
                 const SizedBox(height: 8),
                 Text(
                   _emailSent ? 'Email terkirim!' : 'Lupa Password',
                   style: const TextStyle(
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
                   child: _emailSent ? _buildSuccessContent() : _buildFormContent(),
                 ),
               ],
             ),
           ),
         ),
       );
     }

     Widget _buildFormContent() {
       return Form(
         key: _formKey,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             const Icon(
               Icons.lock_reset,
               size: 60,
               color: AppTheme.primaryColor,
             ),
             const SizedBox(height: 20),
             const Text(
               'Reset Password',
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: AppTheme.primaryColor,
               ),
               textAlign: TextAlign.center,
             ),
             const SizedBox(height: 12),
             const Text(
               'Masukkan email Anda dan kami akan mengirimkan link untuk reset password',
               style: TextStyle(
                 fontSize: 14,
                 color: Colors.grey,
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
             const SizedBox(height: 30),
             ElevatedButton(
               onPressed: _isLoading ? null : _resetPassword,
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
                       'Kirim Link Reset',
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
             ),
           ],
         ),
       );
     }

     Widget _buildSuccessContent() {
       return Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           const Icon(
             Icons.mark_email_read,
             size: 60,
             color: AppTheme.successColor,
           ),
           const SizedBox(height: 20),
           const Text(
             'Email Terkirim!',
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.bold,
               color: AppTheme.primaryColor,
             ),
             textAlign: TextAlign.center,
           ),
           const SizedBox(height: 12),
           Text(
             'Kami telah mengirimkan link reset password ke ${_emailController.text}',
             style: const TextStyle(
               fontSize: 14,
               color: Colors.grey,
             ),
             textAlign: TextAlign.center,
           ),
           const SizedBox(height: 30),
           ElevatedButton(
             onPressed: () {
               Navigator.pop(context);
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: AppTheme.primaryColor,
               foregroundColor: Colors.white,
               padding: const EdgeInsets.symmetric(vertical: 16),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
               elevation: 3,
             ),
             child: const Text(
               'Kembali ke Login',
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
           const SizedBox(height: 12),
           TextButton(
             onPressed: () {
               setState(() {
                 _emailSent = false;
               });
             },
             child: const Text(
               'Kirim Ulang Email',
               style: TextStyle(
                 color: AppTheme.primaryColor,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),
         ],
       );
     }
   }