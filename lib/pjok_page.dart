import 'package:flutter/material.dart';

class PJOKPage extends StatelessWidget {
  const PJOKPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PJOK'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah halaman PJOK',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
