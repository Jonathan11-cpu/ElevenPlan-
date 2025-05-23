import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_page.dart'; // GANTI sesuai nama file kamu

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1A5B9C),
      body: Center(
        child: Icon(
          Icons.school,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
