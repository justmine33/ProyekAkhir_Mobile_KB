import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.indigo.shade700;
    final Color accentYellow = Colors.amber.shade600;
    final Color cardBg = Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(24),
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
                    'Penguin Species Predictor',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Versi 1.0.0',
                    style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
                  ),
                  const SizedBox(height: 32),

                  _buildInfoCard(
                    context: context,
                    title: 'Deskripsi Aplikasi',
                    icon: Icons.info_outline,
                    color: accentYellow,
                    cardBg: cardBg,
                    child: const Text(
                      'Penguin Species Predictor adalah aplikasi berbasis Machine Learning yang membantu memprediksi spesies penguin (Adélie, Chinstrap, atau Gentoo) berdasarkan data fisik seperti panjang paruh, lebar paruh, panjang sayap, dan berat badan. '
                      'Aplikasi ini dibuat untuk mempermudah penelitian dan edukasi tentang satwa laut yang mengagumkan ini.',
                      style: TextStyle(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildInfoCard(
                    context: context,
                    title: 'Fitur Utama',
                    icon: Icons.star_outline,
                    color: accentYellow,
                    cardBg: cardBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _BulletPoint('Prediksi spesies penguin dengan akurasi tinggi'),
                        _BulletPoint('Antarmuka pengguna yang ramah dan modern'),
                        _BulletPoint('Visualisasi hasil prediksi yang jelas'),
                        _BulletPoint('Login & registrasi aman dengan SharedPreferences'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildInfoCard(
                    context: context,
                    title: 'Pengembang',
                    icon: Icons.group,
                    color: accentYellow,
                    cardBg: cardBg,
                    child: const Text(
                      'Dikembangkan dengan penuh semangat oleh:\n\n'
                      'Kelompok 4\n'
                      '   • Putri Jasmine H\n'
                      '   • Nayla Zeanlita Putri\n'
                      '   • Imro Atul Wahidah\n'
                      '   • Octavia Ramadhani\n\n'
                      'Terima kasih telah menggunakan aplikasi kami!',
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildInfoCard(
                    context: context,
                    title: 'Dataset & Kredit',
                    icon: Icons.dataset,
                    color: accentYellow,
                    cardBg: cardBg,
                    child: const Text(
                      'Dataset penguin yang digunakan dalam aplikasi ini berasal dari:\n'
                      'Palmer Penguins Dataset (Kaggle)',
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 30),

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

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Color cardBg,
    required Widget child,
  }) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: cardBg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                height: 1.6,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}