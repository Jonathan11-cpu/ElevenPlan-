import 'package:flutter/material.dart';

class SubjectDetailPage extends StatelessWidget {
  final String subjectName;

  const SubjectDetailPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman untuk $subjectName',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
