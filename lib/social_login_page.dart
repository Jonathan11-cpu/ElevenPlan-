import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

class SocialLoginPage extends StatefulWidget {
  final String provider;
  
  const SocialLoginPage({Key? key, required this.provider}) : super(key: key);

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _successController;
  late Animation<double> _loadingAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  bool _isLoading = true;
  bool _isSuccess = false;
  
  // Informasi profil pengguna setelah login sukses
  String _userName = '';
  String _email = '';
  String? _photoUrl;
  
  @override
  void initState() {
    super.initState();
    
    // Controller untuk animasi loading
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    _loadingAnimation = Tween<double>(begin: 0, end: 1).animate(_loadingController);
    
    // Controller untuk animasi sukses
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: Curves.elasticOut,
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Simulasi proses otentikasi
    _performAuthentication();
  }
  
  // Simulasi proses otentikasi dengan provider
  Future<void> _performAuthentication() async {
    // Tunggu sebentar untuk mensimulasikan proses otentikasi
    await Future.delayed(const Duration(seconds: 2));
    
    // Set data pengguna sesuai provider
    setState(() {
      _isLoading = false;
      _isSuccess = true;
      
      // Isi data dummy sesuai provider
      switch (widget.provider) {
        case 'Google':
          _userName = 'User Google';
          _email = 'user@gmail.com';
          _photoUrl = null; // URL gambar avatar akan disimulasikan dengan inisial
          break;
        case 'Facebook':
          _userName = 'User Facebook';
          _email = 'user@facebook.com';
          _photoUrl = null;
          break;
        case 'Apple':
          _userName = 'User Apple';
          _email = 'user@icloud.com';
          _photoUrl = null;
          break;
      }
    });
    
    // Mainkan animasi sukses
    _successController.forward();
    
    // Tunggu sebentar kemudian navigasi ke halaman utama
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
            opacity: animation,
            child: const HomePage(),
          ),
        ),
      );
    }
  }
  
  @override
  void dispose() {
    _loadingController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient sama dengan LoginPage
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A1128),
                  Color(0xFF1A5B9C),
                  Color(0xFF034C8C),
                ],
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo sesuai provider
                    _buildProviderLogo(),
                    
                    const SizedBox(height: 40),
                    
                    if (_isLoading) 
                      _buildLoadingIndicator()
                    else if (_isSuccess) 
                      _buildSuccessContent(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProviderLogo() {
    IconData iconData;
    Color backgroundColor;
    Color iconColor;
    
    switch (widget.provider) {
      case 'Google':
        iconData = Icons.g_mobiledata;
        backgroundColor = Colors.white;
        iconColor = Colors.red;
        break;
      case 'Facebook':
        iconData = Icons.facebook;
        backgroundColor = const Color(0xFF3B5998);
        iconColor = Colors.white;
        break;
      case 'Apple':
        iconData = Icons.apple;
        backgroundColor = Colors.black;
        iconColor = Colors.white;
        break;
      default:
        iconData = Icons.login;
        backgroundColor = Colors.blueGrey;
        iconColor = Colors.white;
    }
    
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: 50,
        ),
      ),
    );
  }
  
  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        // Animasi loading berputar
        AnimatedBuilder(
          animation: _loadingAnimation,
          builder: (context, child) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 4,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(60, 60),
                    painter: LoadingPainter(_loadingAnimation.value),
                  ),
                ],
              ),
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'Menghubungkan dengan ${widget.provider}...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        const Text(
          'Mohon tunggu...',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSuccessContent() {
    return Column(
      children: [
        // Animasi check mark untuk sukses
        ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Login ${widget.provider} Berhasil!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Informasi profil pengguna
        FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: _photoUrl == null
                      ? Text(
                          _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  backgroundImage: _photoUrl != null ? NetworkImage(_photoUrl!) : null,
                ),
                
                const SizedBox(height: 16),
                
                // Nama pengguna
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5B9C),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Email
                Text(
                  _email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Text sedang memuat halaman utama
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A5B9C)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Memuat halaman utama...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter untuk loading spinner
class LoadingPainter extends CustomPainter {
  final double progress;
  
  LoadingPainter(this.progress);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A5B9C)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Arc yang berputar
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      -0.5 * 3.14 + (progress * 2 * 3.14), // Starts from the top
      0.8 * 3.14, // 80% of a full circle
      false,
      paint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}