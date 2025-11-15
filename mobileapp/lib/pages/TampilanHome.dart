import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_page.dart';
import 'input_page.dart';
import 'login_screen.dart';

class TampilanHome extends StatelessWidget {
  const TampilanHome({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout berhasil! Sampai jumpa lagi!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.indigo.shade700;
    final Color accentYellow = Colors.amber.shade600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Penguin Species Predictor'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => AboutPage())),
          ),
        ],
      ),
      drawer: _buildDrawer(context, primaryBlue),
      
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue.shade200, Colors.white],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/image/logo/logo.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.ac_unit,
                              size: 64, color: Colors.white);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                      shadows: const [
                        Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black26),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Penguin Species Predictor',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Tahukah kamu?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: accentYellow,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Penguin adalah burung yang tidak bisa terbang, tapi jago berenang! '
                            'Mereka hidup di belahan bumi selatan dan memiliki bulu tebal + lapisan lemak '
                            'untuk bertahan di suhu ekstrem hingga -50°C.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.blue.shade800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          OutlinedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text('Fakta Penguin',
                                      style: TextStyle(color: primaryBlue)),
                                  content: const Text(
                                    '• Penguin bisa menahan napas hingga 20 menit saat menyelam\n'
                                    '• Mereka "terbang" di dalam air dengan kecepatan hingga 36 km/jam\n'
                                    '• Betina & jantan bergantian menjaga telur',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Tutup',
                                          style:
                                              TextStyle(color: accentYellow)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.auto_awesome, size: 20),
                            label: const Text('Fakta Menarik Lainnya'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: accentYellow,
                              side: BorderSide(color: accentYellow, width: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const InputPage()),
                        );
                      },
                      icon: const Icon(Icons.trending_up,
                          size: 28, color: Colors.lightBlue),
                      label: const Text(
                        'Mulai Prediksi Spesies',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        elevation: 12,
                        shadowColor: primaryBlue.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  Text(
                    'Aplikasi ini menggunakan Kecerdasan Buatan untuk memprediksi spesies penguin '
                    'berdasarkan ukuran paruh, sayap, dan berat badan.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Text(
                    '© 2025 Kelompok 4. All Rights Reserved.\nMade with ❤️ ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, Color primaryBlue) {
    return Drawer(
      child: Container(
        color: primaryBlue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ac_unit, size: 60, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Penguin Predictor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _drawerItem(context, Icons.home, 'Home', const TampilanHome()),
            _drawerItem(
                context, Icons.trending_up, 'Prediksi', const InputPage()),
            _drawerItem(context, Icons.info, 'Tentang', const AboutPage()),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}