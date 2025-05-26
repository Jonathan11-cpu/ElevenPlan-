import 'package:flutter/material.dart';
// Import halaman-halaman yang diperlukan
import 'poin_page.dart';
import 'keamanan_page.dart';
import 'faq_page.dart';
import 'welcome_page.dart'; // Import welcome page

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.height < 700;
    final bool isTinyScreen = size.height < 600;
    
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.all(isTinyScreen ? 16.0 : 20.0),
                      child: Text(
                        'Profil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTinyScreen ? 18 : (isSmallScreen ? 20 : 22),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    // Profile Section - Compact and Responsive
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: isTinyScreen ? 16 : 20),
                      padding: EdgeInsets.all(isTinyScreen ? 16 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Profile Avatar - Responsive Size
                          Container(
                            width: isTinyScreen ? 60 : (isSmallScreen ? 65 : 70),
                            height: isTinyScreen ? 60 : (isSmallScreen ? 65 : 70),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF1E3A8A),
                                  Color(0xFF3B82F6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(isTinyScreen ? 30 : (isSmallScreen ? 32.5 : 35)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'J',
                                style: TextStyle(
                                  fontSize: isTinyScreen ? 22 : (isSmallScreen ? 25 : 28),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: isTinyScreen ? 12 : 16),
                          
                          // Username Field - Compact
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: isTinyScreen ? 11 : 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              SizedBox(height: isTinyScreen ? 4 : 6),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTinyScreen ? 12 : 16,
                                  vertical: isTinyScreen ? 10 : 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Jonathan Arya',
                                  style: TextStyle(
                                    fontSize: isTinyScreen ? 13 : 14,
                                    color: const Color(0xFF1E293B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: isTinyScreen ? 12 : 16),
                          
                          // Edit Profile Button - Compact
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1E3A8A),
                                    Color(0xFF3B82F6),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showEditProfileDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(vertical: isTinyScreen ? 10 : 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Edit Profil',
                                  style: TextStyle(
                                    fontSize: isTinyScreen ? 13 : 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: isTinyScreen ? 12 : 16),
                    
                    // Menu Items - Flexible Height
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                          isTinyScreen ? 16 : 20, 
                          0, 
                          isTinyScreen ? 16 : 20, 
                          isTinyScreen ? 16 : 20
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMenuItem(
                              icon: Icons.stars_rounded,
                              title: 'Poin',
                              iconColor: const Color(0xFF3B82F6),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PoinPage(),
                                  ),
                                );
                              },
                              isTinyScreen: isTinyScreen,
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.security_rounded,
                              title: 'Keamanan',
                              iconColor: const Color(0xFF059669),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const KeamananPage(),
                                  ),
                                );
                              },
                              isTinyScreen: isTinyScreen,
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.help_center_rounded,
                              title: 'FAQs',
                              iconColor: const Color(0xFF0891B2),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FaqPage(),
                                  ),
                                );
                              },
                              isTinyScreen: isTinyScreen,
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.logout_rounded,
                              title: 'Logout',
                              iconColor: const Color(0xFFDC2626),
                              onTap: () {
                                _showLogoutDialog(context);
                              },
                              isLast: true,
                              isTinyScreen: isTinyScreen,
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
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
    bool isLast = false,
    bool isTinyScreen = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isLast ? Radius.zero : const Radius.circular(0),
          bottom: isLast ? const Radius.circular(20) : Radius.zero,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTinyScreen ? 16 : 20,
            vertical: isTinyScreen ? 14 : 16,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isTinyScreen ? 6 : 8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: isTinyScreen ? 18 : 20,
                ),
              ),
              SizedBox(width: isTinyScreen ? 12 : 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isTinyScreen ? 14 : 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: isTinyScreen ? 14 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: const Color(0xFFF1F5F9),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController usernameController = 
        TextEditingController(text: 'jonathanraj10');
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(24),
          title: const Text(
            'Edit Profil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan username baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil berhasil diperbarui!')),
                  );
                },
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(24),
          title: const Text(
            'Konfirmasi Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              fontSize: 20,
            ),
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar dari aplikasi?',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  // Tutup dialog terlebih dahulu
                  Navigator.pop(context);
                  
                  // Navigasi ke welcome page dan hapus semua halaman sebelumnya
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomePage(),
                    ),
                    (route) => false, // Hapus semua route sebelumnya
                  );
                  
                  // Tampilkan pesan logout berhasil
                  Future.delayed(const Duration(milliseconds: 500), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout berhasil!'),
                        backgroundColor: Color(0xFF059669),
                      ),
                    );
                  });
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}