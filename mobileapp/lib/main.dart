import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/landing_page.dart';
import 'pages/login_screen.dart';
import 'controller/controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PenguinPredictionProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penguin Species Predictor',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data! ? HomeScreen() : LoginScreen();
        },
      ),
    );
  }
}
