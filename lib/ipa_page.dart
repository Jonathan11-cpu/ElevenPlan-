import 'package:flutter/material.dart';

class IpaPage extends StatelessWidget {
  const IpaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IPA')),
      body: const Center(
        child: Text('Halaman IPA'),
      ),
    );
  }
}
