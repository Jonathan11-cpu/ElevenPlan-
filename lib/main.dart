import 'package:flutter/material.dart';
import 'splash_screen.dart'; // atau file pertama yang kamu pakai

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElevenPlan!', // ✅ Ganti nama aplikasi di sini
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
