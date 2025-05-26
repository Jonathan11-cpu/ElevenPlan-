import 'package:flutter/material.dart';
import 'tugasips1_page.dart';
import 'tugasips2_page.dart';
import 'tugasips3_page.dart';

class IpsPage extends StatelessWidget {
  const IpsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tugasList = [
      {
        'judul': 'TUGAS 1 – Sejarah Indonesia',
        'tanggal': '20 Agustus 2025',
        'status': 'belum',
      },
      {
        'judul': 'TUGAS 2 – Geografi Nusantara',
        'tanggal': '18 Agustus 2025',
        'status': 'belum',
      },
      {
        'judul': 'TUGAS 3 – Ekonomi dan Sosial',
        'tanggal': '16 Agustus 2025',
        'status': 'selesai',
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          // Header Section with Full Gradient (including status bar)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.blue[400]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  children: [
                    // Navigation Bar
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Expanded(
                          child: Text(
                            'Welcome to',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    
                    // App Title
                    const Text(
                      'ElevenPlan!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Subject Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'IPS',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Teacher Info
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange[300],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guru',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Pak Budi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Content Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: tugasList.length,
                  itemBuilder: (context, index) {
                    final tugas = tugasList[index];
                    final isSelesai = tugas['status'] == 'selesai';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelesai 
                              ? Colors.green[400]!
                              : Colors.red[400]!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (tugas['judul'].contains('TUGAS 1')) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const TugasIps1Page()));
                            } else if (tugas['judul'].contains('TUGAS 2')) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const TugasIps2Page()));
                            } else if (tugas['judul'].contains('TUGAS 3')) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const TugasIps3Page()));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                // Book Icon
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[400]!.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.blue[600],
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Task Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tugas baru: ${tugas['judul']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Diterbitkan pada: ${tugas['tanggal']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Status Icon
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelesai 
                                        ? Colors.green[400]
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelesai 
                                          ? Colors.green[400]!
                                          : Colors.red[400]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelesai
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}