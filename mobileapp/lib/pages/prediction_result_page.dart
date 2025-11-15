import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';

class PredictionResultPage extends StatelessWidget {
  const PredictionResultPage({super.key});

  Map<String, dynamic> _getSpeciesInfo(String species) {
    switch (species.toLowerCase()) {
      case 'adelie':
        return {
          'image': 'assets/image/penguins/adelie.jpeg',
          'color': Colors.orange.shade700,
          'name': 'Adélie',
          'desc': 'Penguin kecil yang lincah dan suka berkelompok besar.'
        };
      case 'chinstrap':
        return {
          'image': 'assets/image/penguins/chinstrap.jpg',
          'color': Colors.purple.shade700,
          'name': 'Chinstrap',
          'desc': 'Dikenali dari garis hitam di bawah dagu seperti tali dagu.'
        };
      case 'gentoo':
        return {
          'image': 'assets/image/penguins/gentoo.jpeg',
          'color': Colors.teal.shade700,
          'name': 'Gentoo',
          'desc': 'Penguin terbesar ketiga, jago berenang cepat.'
        };
      default:
        return {
          'image': null,
          'color': Colors.grey,
          'name': 'Tidak terdeteksi',
          'desc': 'Data tidak cukup untuk prediksi.'
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PenguinPredictionProvider>(context);
    final Color primaryBlue = Colors.indigo.shade700;
    final Color accentYellow = Colors.amber.shade600;

    final result = provider.predictionResult ?? 'Tidak terdeteksi';
    final speciesInfo = _getSpeciesInfo(result);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Hasil Prediksi'),
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


                  Text(
                    'Prediksi Selesai!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryBlue),
                  ),
                  const SizedBox(height: 32),

                  Card(
                    elevation: 16,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 20, offset: const Offset(0, 10)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: speciesInfo['image'] != null
                                  ? Image.asset(
                                      speciesInfo['image'],
                                      width: 180,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 180,
                                          height: 180,
                                          color: Colors.red.shade100,
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.error, color: Colors.red),
                                              Text('Foto tidak ada!', style: TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Icon(Icons.help_outline, size: 80, color: speciesInfo['color']),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            'Spesies:',
                            style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            speciesInfo['name'],
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: speciesInfo['color'],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              speciesInfo['desc'],
                              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Text(
                    'Data yang Anda Masukkan:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentYellow),
                  ),
                  const SizedBox(height: 16),

                  _buildDataRow('Panjang Paruh', '${provider.panjangParuhController.text} mm'),
                  _buildDataRow('Lebar Paruh', '${provider.lebarParuhController.text} mm'),
                  _buildDataRow('Panjang Sayap', '${provider.panjangSayapController.text} mm'),
                  _buildDataRow('Berat Badan', '${provider.beratBadanController.text} g'),
                  _buildDataRow(
                    'Jenis Kelamin',
                    provider.jenisKelamin == 'Male'
                        ? 'Jantan'
                        : provider.jenisKelamin == 'Female'
                            ? 'Betina'
                            : '-',
                  ),

                  const SizedBox(height: 40),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.refresh, color: Colors.blueGrey,),
                          label: const Text('Prediksi Lagi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            elevation: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo.shade700)),
        ],
      ),
    );
  }
}