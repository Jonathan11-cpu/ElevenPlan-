import 'package:flutter/material.dart';
import 'matematika_page.dart';
import 'bahasa_inggris_page.dart';
import 'ipa_page.dart';
import 'ips_page.dart';
import 'b_jawa_page.dart';
import 'agama_page.dart';
import 'seni_page.dart';

import 'subject_detail_page.dart';
import 'semua_tugas_page.dart';
import 'pengaturan_page.dart';
import 'tantangan_page.dart';
import 'notifikasi_page.dart';
import 'leaderboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Widget> _pages = [
    const HomeContent(),
    SemuaTugasPage(),
    const LeaderboardPage(),
    PengaturanPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0D47A1), // Dark blue
              Color(0xFF1976D2), // Medium blue
              Color(0xFF42A5F5), // Light blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            showUnselectedLabels: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            items: [
              BottomNavigationBarItem(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.home_menu,
                  progress: _animation,
                  color: _selectedIndex == 0 ? Colors.white : Colors.white.withOpacity(0.6),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: _selectedIndex == 1 ? 1 : 0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 1.0 + (value * 0.2),
                          child: Icon(
                            Icons.school,
                            color: _selectedIndex == 1 ? Colors.white : Colors.white.withOpacity(0.6),
                          ),
                        );
                      },
                    ),
                    // Badge indicator for subjects
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                label: 'Mapel',
              ),
              BottomNavigationBarItem(
                icon: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: _selectedIndex == 2 ? 1 : 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 1.0 + (value * 0.2),
                      child: Icon(
                        Icons.leaderboard,
                        color: _selectedIndex == 2 ? Colors.white : Colors.white.withOpacity(0.6),
                      ),
                    );
                  },
                ),
                label: 'Leaderboard',
              ),
              BottomNavigationBarItem(
                icon: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: _selectedIndex == 3 ? 1 : 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 1.0 + (value * 0.2),
                      child: Icon(
                        Icons.person,
                        color: _selectedIndex == 3 ? Colors.white : Colors.white.withOpacity(0.6),
                      ),
                    );
                  },
                ),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0D47A1).withOpacity(0.05)
      ..style = PaintingStyle.fill;
    
    // Blue accent circles
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.2),
        50.0 + (i * 20),
        paint,
      );
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.7),
        70.0 + (i * 15),
        paint,
      );
    }
    
    // Additional decorative elements
    paint.color = const Color(0xFF2196F3).withOpacity(0.03);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height * 0.4, size.width * 0.6, size.height * 0.3),
        const Radius.circular(30),
      ),
      paint,
    );
    
    paint.color = const Color(0xFF64B5F6).withOpacity(0.04);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.5, size.height * 0.1, size.width * 0.5, size.height * 0.2),
        const Radius.circular(20),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  // Updated subjects data - IPS and Agama now have incomplete tasks
  final List<Map<String, dynamic>> subjects = const [
    {'nama': 'Matematika', 'icon': Icons.calculate, 'tugas': 3, 'selesai': 1},
    {'nama': 'Bahasa Inggris', 'icon': Icons.language, 'tugas': 2, 'selesai': 0},
    {'nama': 'IPA', 'icon': Icons.science, 'tugas': 4, 'selesai': 1},
    {'nama': 'IPS', 'icon': Icons.public, 'tugas': 3, 'selesai': 1}, // Updated: 3 tugas total, 1 selesai (2 belum selesai)
    {'nama': 'B. Jawa', 'icon': Icons.menu_book, 'tugas': 3, 'selesai': 0},
    {'nama': 'Agama', 'icon': Icons.church, 'tugas': 4, 'selesai': 2}, // Updated: 4 tugas total, 2 selesai (2 belum selesai)
    {'nama': 'Seni', 'icon': Icons.palette, 'tugas': 5, 'selesai': 1},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuad,
    ));

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 15000),
      vsync: this,
    );
    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_backgroundController);
    _backgroundController.repeat();

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // White background with subtle pattern
        Container(
          color: Colors.white,
        ),
        
        // Background pattern with animation
        AnimatedBuilder(
          animation: _backgroundAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(),
              size: Size.infinite,
            );
          },
        ),

        // Main content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Header with bigger container and clearer fonts
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE3F2FD), // Very light blue
                            Color(0xFFBBDEFB), // Light blue
                            Color(0xFFE1F5FE), // Another light blue shade
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Halo,',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blueGrey[600],
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.8,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds),
                                  child: const Text(
                                    'Jonathan Arya',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Selamat datang kembali!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey[500],
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Hero(
                            tag: 'notifikasi_icon',
                            child: Material(
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Color(0xFF0D47A1),
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) =>
                                                const NotifikasiPage(),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Improved Notification Badge
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
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

                  // Tantangan - Updated with cooler blue gradient button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE3F2FD), // Very light blue
                          Color(0xFFBBDEFB), // Light blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tantangan Hari Ini!',
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Selesaikan 3 tugas untuk dapat badge baru.',
                                style: TextStyle(
                                  color: Colors.blueGrey[600],
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1565C0), // Darker blue
                                      Color(0xFF2196F3), // Medium blue
                                      Color(0xFF42A5F5), // Lighter blue
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1976D2).withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const TantanganPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text(
                                    "Mulai",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)], // Cool blue gradient
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: const Icon(
                              Icons.flag,
                              size: 42,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        color: Colors.blueGrey[700],
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pelajaran',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1976D2).withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Mapel scrollable vertically
                  Expanded(
                    child: ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        String nama = subjects[index]['nama']!;
                        IconData icon = subjects[index]['icon']!;
                        int tugas = subjects[index]['tugas']!;
                        int selesai = subjects[index]['selesai']!;
                        int belumSelesai = tugas - selesai;
                        
                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 400 + (index * 100)),
                          curve: Curves.easeOutQuad,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(100 * (1 - value), 0),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.blue[100],
                                  highlightColor: Colors.blue[50],
                                  onTap: () {
                                    Widget page;
                                    switch (nama) {
                                      case 'Matematika':
                                        page = const MatematikaPage();
                                        break;
                                      case 'Bahasa Inggris':
                                        page = const BahasaInggrisPage();
                                        break;
                                      case 'IPA':
                                        page = const IpaPage();
                                        break;
                                      case 'IPS':
                                        page = const IpsPage();
                                        break;
                                      case 'B. Jawa':
                                        page = const BJawaPage();
                                        break;
                                      case 'Agama':
                                        page = const AgamaPage();
                                        break;
                                      case 'Seni':
                                        page = const SeniPage();
                                        break;
                                      default:
                                        page = SubjectDetailPage(subjectName: nama);
                                    }
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => page,
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Hero(
                                              tag: 'subject_icon_$nama',
                                              child: Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFFE3F2FD), // Very light blue
                                                      Color(0xFFBBDEFB), // Light blue
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0xFF1976D2).withOpacity(0.3),
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(icon, size: 32, color: const Color(0xFF0D47A1)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    nama,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Color(0xFF0D47A1),
                                                      letterSpacing: 0.4,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  // Improved task progress display
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.assignment,
                                                        size: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                      const SizedBox(width: 4),
                                                      if (belumSelesai > 0)
                                                        Text(
                                                          '$belumSelesai dari $tugas tugas belum dikerjakan',
                                                          style: TextStyle(
                                                            color: belumSelesai > 0 ? Colors.orange[700] : Colors.grey[700],
                                                            fontSize: 13,
                                                            fontWeight: belumSelesai > 0 ? FontWeight.w500 : FontWeight.normal,
                                                          ),
                                                        )
                                                      else
                                                        Text(
                                                          'Semua tugas selesai',
                                                          style: TextStyle(
                                                            color: Colors.green[700],
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE3F2FD),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                                color: Color(0xFF0D47A1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Show badge only if there are incomplete tasks
                                      if (belumSelesai > 0)
                                        Positioned(
                                          top: 14,
                                          right: 42,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white, width: 1),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 2,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}