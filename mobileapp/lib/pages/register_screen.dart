import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  bool _validate() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty) {
      _showSnackBar('Username tidak boleh kosong', Colors.orange);
      return false;
    }
    if (password.isEmpty) {
      _showSnackBar('Password tidak boleh kosong', Colors.orange);
      return false;
    }
    if (password.length < 3) {
      _showSnackBar('Password minimal 3 karakter', Colors.orange);
      return false;
    }
    if (password != confirmPassword) {
      _showSnackBar('Password tidak cocok', Colors.red);
      return false;
    }
    return true;
  }

  Future<void> _register() async {
    if (!_validate()) return;

    setState(() => _isLoading = true);

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString('users');

    print('\n========== REGISTER START ==========');
    print('Registering: $username / $password');
    print('Existing raw data: $existingData');

    List<Map<String, String>> users = [];

    if (existingData != null && existingData.isNotEmpty) {
      final decoded = jsonDecode(existingData) as List;
      users = decoded.map((e) => {
            'username': e['username'].toString(),
            'password': e['password'].toString(),
          }).toList();
      print('Users BEFORE add: $users');
    }

    if (users.any((u) => u['username'] == username)) {
      _showSnackBar('Username sudah terdaftar!', Colors.red);
      setState(() => _isLoading = false);
      return;
    }

    users.add({'username': username, 'password': password});
    final jsonString = jsonEncode(users);
    await prefs.setString('users', jsonString);

    final saved = prefs.getString('users');
    print('Saved JSON: $saved');
    print('========== REGISTER END ==========\n');

    _showSnackBar('Registrasi berhasil! Silakan login.', Colors.green);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pop(context);
    });

    setState(() => _isLoading = false);
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.indigo.shade700;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Daftar Akun'),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: primaryBlue,
                        child: const Icon(Icons.ac_unit, size: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Buat Akun Baru',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryBlue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Isi data di bawah ini untuk mendaftar',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 32),

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
                      const SizedBox(height: 16),

                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Konfirmasi Password',
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

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
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
                              : const Text('DAFTAR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Sudah punya akun? Login di sini',
                          style: TextStyle(color: primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

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