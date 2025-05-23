import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Biru tua
              Color(0xFF3B82F6), // Biru sedang
              Color(0xFF93C5FD), // Biru muda
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header dengan navigasi back
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'FAQs',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0891B2), Color(0xFF06B6D4)],
                          ),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0891B2).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.help_center_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      const Text(
                        'Frequently Asked Questions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // FAQ List
                      Expanded(
                        child: ListView(
                          children: [
                            _buildFaqItem(
                              'Bagaimana cara mengumpulkan poin?',
                              'Anda dapat mengumpulkan poin dengan menyelesaikan quiz, login harian, mengundang teman, dan berbagai aktivitas lainnya dalam aplikasi.',
                            ),
                            _buildFaqItem(
                              'Apakah data saya aman?',
                              'Ya, kami menggunakan enkripsi tingkat tinggi dan mengikuti standar keamanan industri untuk melindungi data pribadi Anda.',
                            ),
                            _buildFaqItem(
                              'Bagaimana cara mengaktifkan autentikasi dua faktor?',
                              'Buka menu Keamanan di halaman profil, lalu aktifkan toggle "Autentikasi Dua Faktor". Ikuti petunjuk yang muncul untuk menyelesaikan setup.',
                            ),
                            _buildFaqItem(
                              'Bisakah saya mengubah username?',
                              'Ya, Anda dapat mengubah username melalui halaman profil dengan menekan tombol "Edit Profil".',
                            ),
                            _buildFaqItem(
                              'Bagaimana cara menghubungi customer service?',
                              'Anda dapat menghubungi kami melalui email support@example.com atau melalui fitur chat dalam aplikasi.',
                            ),
                            _buildFaqItem(
                              'Apakah aplikasi ini gratis?',
                              'Ya, aplikasi ini gratis untuk digunakan dengan berbagai fitur premium yang tersedia.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0891B2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.help_outline_rounded,
            color: Color(0xFF0891B2),
            size: 20,
          ),
        ),
        iconColor: const Color(0xFF0891B2),
        collapsedIconColor: const Color(0xFF6B7280),
        children: [
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}