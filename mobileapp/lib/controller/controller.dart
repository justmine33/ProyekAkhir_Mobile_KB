import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PenguinPredictionProvider with ChangeNotifier {
  final TextEditingController panjangParuhController = TextEditingController();
  final TextEditingController lebarParuhController = TextEditingController();
  final TextEditingController panjangSayapController = TextEditingController();
  final TextEditingController beratBadanController = TextEditingController();
  
  String? jenisKelamin;
  String? predictionResult;
  bool isLoading = false;
  String? errorMessage;

  void setJenisKelamin(String? value) {
    jenisKelamin = value;
    notifyListeners();
  }

  Future<void> predict() async {
    if (panjangParuhController.text.isEmpty ||
        lebarParuhController.text.isEmpty ||
        panjangSayapController.text.isEmpty ||
        beratBadanController.text.isEmpty ||
        jenisKelamin == null) {
      errorMessage = 'Mohon lengkapi semua data!';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    predictionResult = null;
    notifyListeners();

    final url = Uri.parse('http://127.0.0.1:8000/api/predict');

    final body = jsonEncode({
      "data": {
        "culmen_length_mm": double.tryParse(panjangParuhController.text) ?? 0.0,
        "culmen_depth_mm": double.tryParse(lebarParuhController.text) ?? 0.0,
        "flipper_length_mm": double.tryParse(panjangSayapController.text) ?? 0.0,
        "body_mass_g": double.tryParse(beratBadanController.text) ?? 0.0,
        "sex": jenisKelamin == 'Male' ? 'MALE' : 'FEMALE',
      }
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['species'] != null) {
          predictionResult = data['species'];
        } else if (data['prediction'] is List && data['prediction'].isNotEmpty) {
          int classId = data['prediction'][0];
          predictionResult = _mapClassToSpecies(classId);
        } else {
          predictionResult = 'Predicted (no label)';
        }
        
        errorMessage = null;
      } else {
        errorMessage = 'Server Error: ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      errorMessage = 'Connection Error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  String _mapClassToSpecies(int classPrediction) {
    switch (classPrediction) {
      case 0:
        return 'Adelie';
      case 1:
        return 'Chinstrap';
      case 2:
        return 'Gentoo';
      default:
        return 'Unknown species';
    }
  }

  void clearInputData() {
    panjangParuhController.clear();
    lebarParuhController.clear();
    panjangSayapController.clear();
    beratBadanController.clear();
    jenisKelamin = null;
    predictionResult = null;
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    panjangParuhController.dispose();
    lebarParuhController.dispose();
    panjangSayapController.dispose();
    beratBadanController.dispose();
    super.dispose();
  }
}