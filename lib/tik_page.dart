import 'package:flutter/material.dart';

class TIKPage extends StatelessWidget {
  const TIKPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIK'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah halaman TIK',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
