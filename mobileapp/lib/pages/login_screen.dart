import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'register_screen.dart';
import 'TampilanHome.dart';
import 'landing_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool _validate() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      _showSnackBar('Username tidak boleh kosong', Colors.orange);
      return false;
    }
    if (password.isEmpty) {
      _showSnackBar('Password tidak boleh kosong', Colors.orange);
      return false;
    }
    return true;
  }

  Future<void> _login() async {
    if (!_validate()) return;
    setState(() => _isLoading = true);

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString('users');

    if (existingData == null) {
      _showSnackBar('Belum ada akun terdaftar.', Colors.orange);
      setState(() => _isLoading = false);
      return;
    }

    final List users = jsonDecode(existingData);
    final matchedUser = users.firstWhere(
      (u) => u['username'] == username && u['password'] == password,
      orElse: () => null,
    );

    if (matchedUser != null) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      _showSnackBar('Login berhasil!', Colors.green);

      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const TampilanHome(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
          ),
          (route) => false,
        );
      });
    } else {
      _showSnackBar('Username atau password salah!', Colors.red);
    }
    setState(() => _isLoading = false);
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryBlue = isDark ? Colors.blue.shade800 : Colors.indigo.shade700;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        leading: IconButton( // TOMBOL BACK DITAMBAH DI SINI
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke HomeScreen (halaman splash/landing)
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const HomeScreen(),
                transitionDuration: const Duration(milliseconds: 400),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo penguin
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: primaryBlue,
                        child: const Icon(Icons.ac_unit, size: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Masuk ke Akun Anda',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryBlue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Silakan login untuk melanjutkan',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 32),

                      // Username Field — DESAIN LOGIN KLASIK (putih + border abu)
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Tombol Login
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 6,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                )
                              : const Text('MASUK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Link Register
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        child: Text(
                          'Belum punya akun? Daftar di sini',
                          style: TextStyle(color: primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}