import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:math' as math;
import 'signup_page.dart';
import 'social_login_page.dart'; // Import halaman login sosial

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  // Controller untuk animasi utama
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  // Controller untuk animasi berkedip
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;
  
  // Controller untuk animasi tombol 
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;
  
  // Controller untuk animasi partikel
  late AnimationController _particleController;
  
  // Particles for background
  final List<ParticleModel> _particles = List.generate(
    20,
    (_) => ParticleModel.random(),
  );
  
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isPasswordVisible = false;
  
  // Error state untuk form validation
  String? _usernameError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    
    // Setup animasi utama
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );
    
    // Setup animasi berkedip
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _blinkAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(_blinkController);
    
    // Setup animasi tombol
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    
    _buttonAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Setup animasi partikel
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _blinkController.dispose();
    _buttonController.dispose();
    _particleController.dispose();
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background sama dengan WelcomePage
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
          
          // Particles Animation
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: ParticlesPainter(_particles, _particleController),
          ),
          
          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: _buildLoginCard(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 380),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo dengan animasi berkedip
            AnimatedBuilder(
              animation: _blinkAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _blinkAnimation.value,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A5B9C),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A5B9C).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Judul dengan font tegas
            const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: Color(0xFF1A5B9C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Siap Menyelesaikan Tugas?',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF616161),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            // Username field
            _buildTextField(
              controller: userController,
              icon: Icons.person_outline,
              labelText: 'Username',
              errorText: _usernameError,
              onChanged: (_) => setState(() => _usernameError = null),
            ),
            const SizedBox(height: 16),
            
            // Password field
            _buildTextField(
              controller: passController,
              icon: Icons.lock_outline,
              labelText: 'Password',
              isPassword: true,
              errorText: _passwordError,
              onChanged: (_) => setState(() => _passwordError = null),
            ),
            
            const SizedBox(height: 24),
            
            // Login button dengan animasi tekan
            GestureDetector(
              onTapDown: (_) {
                _buttonController.forward();
              },
              onTapUp: (_) {
                _buttonController.reverse();
                _validateAndLogin(context);
              },
              onTapCancel: () {
                _buttonController.reverse();
              },
              child: AnimatedBuilder(
                animation: _buttonAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _buttonAnimation.value,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1A5B9C),
                            Color(0xFF3D85C6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1A5B9C).withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'MASUK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(child: Divider(thickness: 1.5)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'atau',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 1.5)),
              ],
            ),
            const SizedBox(height: 24),
            
            // Tombol sosial media login - Memanggil halaman login sosial
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  color: Colors.white,
                  icon: Icons.g_mobiledata,
                  iconColor: Colors.red,
                  onTap: () => _navigateToSocialLogin(context, 'Google'),
                ),
                _buildSocialButton(
                  color: const Color(0xFF3B5998),
                  icon: Icons.facebook,
                  iconColor: Colors.white,
                  onTap: () => _navigateToSocialLogin(context, 'Facebook'),
                ),
                _buildSocialButton(
                  color: Colors.black,
                  icon: Icons.apple,
                  iconColor: Colors.white,
                  onTap: () => _navigateToSocialLogin(context, 'Apple'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum memiliki akun? ',
                  style: TextStyle(
                    color: Color(0xFF616161),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
                          opacity: animation,
                          child: const SignUpPage(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF1A5B9C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    bool isPassword = false,
    String? errorText,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0xFFA0A5BD),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF1A5B9C),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,
                    color: const Color(0xFFA0A5BD),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF1A5B9C), width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          errorText: errorText,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required Color color,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
      ),
    );
  }

  // Method untuk navigasi ke halaman login sosial
  void _navigateToSocialLogin(BuildContext context, String provider) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: SocialLoginPage(provider: provider),
        ),
      ),
    );
  }

  // Validasi form sebelum login
  void _validateAndLogin(BuildContext context) {
    bool isValid = true;
    
    // Validate username
    if (userController.text.trim().isEmpty) {
      setState(() {
        _usernameError = 'Username tidak boleh kosong';
      });
      isValid = false;
    }
    
    // Validate password
    if (passController.text.trim().isEmpty) {
      setState(() {
        _passwordError = 'Password tidak boleh kosong';
      });
      isValid = false;
    }
    
    // Jika semua valid, lanjutkan login
    if (isValid) {
      _showLoadingDialog(context);
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A5B9C)),
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulasi proses login
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Tutup dialog loading
      
      // Navigasi ke halaman utama dengan animasi
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
    });
  }
}

// Particle model for background animation
class ParticleModel {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  
  ParticleModel({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
  
  factory ParticleModel.random() {
    return ParticleModel(
      x: math.Random().nextDouble(),
      y: math.Random().nextDouble(),
      size: math.Random().nextDouble() * 4 + 1,
      speed: math.Random().nextDouble() * 0.015 + 0.005,
      opacity: math.Random().nextDouble() * 0.4 + 0.1,
    );
  }
  
  void update() {
    y += speed;
    if (y > 1) {
      y = 0;
      x = math.Random().nextDouble();
      size = math.Random().nextDouble() * 4 + 1;
      opacity = math.Random().nextDouble() * 0.4 + 0.1;
    }
  }
}

// Custom painter for particle animation
class ParticlesPainter extends CustomPainter {
  final List<ParticleModel> particles;
  final Animation<double> animation;
  
  ParticlesPainter(this.particles, this.animation) : super(repaint: animation);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.update();
      
      final paint = Paint()
        ..color = Colors.white.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}