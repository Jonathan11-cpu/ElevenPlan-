import 'package:flutter/material.dart';

class PoinPage extends StatelessWidget {
  const PoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Dark blue
              Color(0xFF3B82F6), // Medium blue
              Color(0xFF93C5FD), // Light blue
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
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
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
                        'Poinku',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              
              // Main Points Display Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.diamond,
                        color: Color(0xFF3B82F6),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Total Poin',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF3B82F6),
                                Color(0xFF1D4ED8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'J',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '155',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Points Categories Section
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kategori Poin',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      Expanded(
                        child: ListView(
                          children: [
                            _buildCategoryCard(
                              'Matematika',
                              '+87',
                              Icons.calculate_rounded,
                              const Color(0xFFEF4444),
                              const Color(0xFFFEE2E2),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'Bahasa Jawa',
                              '+46',
                              Icons.menu_book_rounded,
                              const Color(0xFFF59E0B),
                              const Color(0xFFFEF3C7),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'Seni Budaya',
                              '+32',
                              Icons.palette_rounded,
                              const Color(0xFF8B5CF6),
                              const Color(0xFFF3E8FF),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'TIK',
                              '+48',
                              Icons.computer_rounded,
                              const Color(0xFF10B981),
                              const Color(0xFFD1FAE5),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'Tugas Literasi',
                              '+10',
                              Icons.auto_stories_rounded,
                              const Color(0xFF3B82F6),
                              const Color(0xFFDBEAFE),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'Tugas Numerasi',
                              '+10',
                              Icons.calculate_rounded,
                              const Color(0xFFEC4899),
                              const Color(0xFFFCE7F3),
                            ),
                            const SizedBox(height: 16),
                            _buildCategoryCard(
                              'Tugas Visual',
                              '+10',
                              Icons.visibility_rounded,
                              const Color(0xFF06B6D4),
                              const Color(0xFFCFFAFE),
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

  Widget _buildCategoryCard(String title, String points, IconData icon, Color accentColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
                letterSpacing: 0.2,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.diamond,
                  color: Color(0xFF06B6D4),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                points,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF059669),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}