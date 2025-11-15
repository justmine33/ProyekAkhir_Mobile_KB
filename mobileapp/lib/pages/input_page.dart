import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'TampilanHome.dart';
import 'prediction_result_page.dart';
import 'about_page.dart';
import '../controller/controller.dart';
import '../pages/login_screen.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final Map<String, String?> _warnings = {
    'panjangParuh': null,
    'lebarParuh': null,
    'panjangSayap': null,
    'beratBadan': null,
  };

  void _updateWarning(String field, String value) {
    setState(() {
      _warnings[field] = value.contains(',')
          ? 'Gunakan titik (.) sebagai pemisah desimal'
          : null;
    });
  }

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
    final provider = Provider.of<PenguinPredictionProvider>(context);

    final Color primaryBlue = Colors.indigo.shade700;
    final Color accentYellow = Colors.amber.shade600;
    final Color cardBg = Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Input Data Penguin'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
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
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: cardBg,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              shape: BoxShape.circle,
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
                          const SizedBox(height: 20),
                          Text(
                            'Prediksi Spesies Penguin',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Masukkan data penguin dengan benar',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 36),
                          _buildCleanField(
                            label: 'Panjang Paruh (mm)',
                            controller: provider.panjangParuhController,
                            accentColor: accentYellow,
                            fieldKey: 'panjangParuh',
                          ),
                          const SizedBox(height: 18),
                          _buildCleanField(
                            label: 'Lebar Paruh (mm)',
                            controller: provider.lebarParuhController,
                            accentColor: accentYellow,
                            fieldKey: 'lebarParuh',
                          ),
                          const SizedBox(height: 18),
                          _buildCleanField(
                            label: 'Panjang Sayap (mm)',
                            controller: provider.panjangSayapController,
                            accentColor: accentYellow,
                            fieldKey: 'panjangSayap',
                          ),
                          const SizedBox(height: 18),
                          _buildCleanField(
                            label: 'Berat Badan (g)',
                            controller: provider.beratBadanController,
                            accentColor: accentYellow,
                            fieldKey: 'beratBadan',
                          ),
                          const SizedBox(height: 24),
                          DropdownButtonFormField<String>(
                            value: provider.jenisKelamin,
                            decoration: InputDecoration(
                              labelText: 'Jenis Kelamin',
                              filled: true,
                              fillColor:Colors.blue.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: accentYellow, width: 2),
                              ),
                            ),
                            dropdownColor: Colors.white,
                            style: TextStyle(
                                color:Colors.black87),
                            items: const [
                              DropdownMenuItem(
                                  value: 'Male', child: Text('Jantan')),
                              DropdownMenuItem(
                                  value: 'Female', child: Text('Betina')),
                            ],
                            onChanged: provider.isLoading
                                ? null
                                : provider.setJenisKelamin,
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: provider.isLoading
                                  ? null
                                  : () async {
                                      final fields = [
                                        provider.panjangParuhController.text,
                                        provider.lebarParuhController.text,
                                        provider.panjangSayapController.text,
                                        provider.beratBadanController.text,
                                      ];

                                      if (fields
                                          .any((text) => text.contains(','))) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Harap gunakan titik (.) sebagai pemisah desimal!'),
                                            backgroundColor: Colors.orange,
                                          ),
                                        );
                                        return;
                                      }

                                      await provider.predict();

                                      if (provider.errorMessage != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text(provider.errorMessage!),
                                            backgroundColor:
                                                Colors.red.shade600,
                                          ),
                                        );
                                      } else if (provider.predictionResult !=
                                          null) {
                                        
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const PredictionResultPage(),
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: provider.isLoading
                                  ? const SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Prediksi Spesies',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (provider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.75),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                        color: accentYellow, strokeWidth: 5),
                    const SizedBox(height: 20),
                    const Text(
                      'Sedang memprediksi...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCleanField({
  required String label,
  required TextEditingController controller,
  required Color accentColor,
  required String fieldKey,
}) {
  return TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]?[0-9]*')),
    ],
    onChanged: (value) {
      _updateWarning(fieldKey, value);
      if (value.contains('.')) {
        final parts = value.split('.');
        if (parts.length > 2) {
          controller.text = '${parts[0]}.${parts[1]}';
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      }
    },
    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.blue.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
      errorText: _warnings[fieldKey],
      errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
    style: const TextStyle(
      color: Colors.black87,
      fontSize: 16,
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
            _drawerItem(context, Icons.trending_up, 'Prediksi', const InputPage()),
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
