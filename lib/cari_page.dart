// lib/pages/cari_page.dart
import 'package:flutter/material.dart';

class CariPage extends StatefulWidget {
  const CariPage({super.key});

  @override
  State<CariPage> createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {
  final List<String> allSubjects = [
    'Matematika',
    'IPA',
    'IPS',
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'PKN',
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = allSubjects
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Pelajaran'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Cari pelajaran...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) => setState(() => query = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: Text(filtered[index]),
                    onTap: () {
                      // bisa arahkan ke detail pelajaran
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
