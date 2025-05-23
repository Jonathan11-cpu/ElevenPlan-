// lib/pages/matematika_page.dart
import 'package:flutter/material.dart';

class MatematikaPage extends StatelessWidget {
  const MatematikaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matematika')),
      body: const Center(
        child: Text('Ini halaman Matematika'),
      ),
    );
  }
}
