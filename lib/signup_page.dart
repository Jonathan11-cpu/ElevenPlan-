import 'package:flutter/material.dart';
import 'dart:math' as math;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
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
  
  // Form controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController nisnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  
  // Error states untuk form validation
  String? _nameError;
  String? _nisnError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

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
    nameController.dispose();
    nisnController.dispose();
    emailController.dispose();
    userController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background - sama dengan LoginPage
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
                        child: _buildSignUpCard(context),
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

  Widget _buildSignUpCard(BuildContext context) {
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
              'SIGN UP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: Color(0xFF1A5B9C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bergabunglah Sekarang!',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF616161),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            // Name field
            _buildTextField(
              controller: nameController,
              icon: Icons.person,
              labelText: 'Nama Lengkap',
              errorText: _nameError,
              onChanged: (_) => setState(() => _nameError = null),
            ),
            const SizedBox(height: 16),
            
            // NISN field
            _buildTextField(
              controller: nisnController,
              icon: Icons.badge_outlined,
              labelText: 'NISN',
              errorText: _nisnError,
              onChanged: (_) => setState(() => _nisnError = null),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            
            // Email field
            _buildTextField(
              controller: emailController,
              icon: Icons.email_outlined,
              labelText: 'Email',
              errorText: _emailError,
              onChanged: (_) => setState(() => _emailError = null),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            
            // Username field
            _buildTextField(
              controller: userController,
              icon: Icons.account_circle_outlined,
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
              isPasswordVisible: _isPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              errorText: _passwordError,
              onChanged: (_) => setState(() => _passwordError = null),
            ),
            const SizedBox(height: 16),
            
            // Confirm Password field
            _buildTextField(
              controller: confirmPassController,
              icon: Icons.lock_outlined,
              labelText: 'Konfirmasi Password',
              isPassword: true,
              isPasswordVisible: _isConfirmPasswordVisible,
              togglePasswordVisibility: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
              errorText: _confirmPasswordError,
              onChanged: (_) => setState(() => _confirmPasswordError = null),
            ),
            
            const SizedBox(height: 24),
            
            // Sign Up button dengan animasi tekan
            GestureDetector(
              onTapDown: (_) {
                _buttonController.forward();
              },
              onTapUp: (_) {
                _buttonController.reverse();
                _validateAndSignUp(context);
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
                          'DAFTAR',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(
                    color: Color(0xFF616161),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
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
    bool? isPasswordVisible,
    VoidCallback? togglePasswordVisibility,
    String? errorText,
    Function(String)? onChanged,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !(isPasswordVisible ?? false),
        keyboardType: keyboardType,
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
          suffixIcon: isPassword && togglePasswordVisibility != null
              ? IconButton(
                  icon: Icon(
                    (isPasswordVisible ?? false) ? Icons.visibility : Icons.visibility_off_outlined,
                    color: const Color(0xFFA0A5BD),
                  ),
                  onPressed: togglePasswordVisibility,
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

  // Validasi form sebelum sign up
  void _validateAndSignUp(BuildContext context) {
    bool isValid = true;
    
    // Validate name
    if (nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = 'Nama tidak boleh kosong';
      });
      isValid = false;
    }
    
    // Validate NISN
    if (nisnController.text.trim().isEmpty) {
      setState(() {
        _nisnError = 'NISN tidak boleh kosong';
      });
      isValid = false;
    } else if (nisnController.text.trim().length != 10) {
      setState(() {
        _nisnError = 'NISN harus 10 digit';
      });
      isValid = false;
    } else if (!_isValidNISN(nisnController.text.trim())) {
      setState(() {
        _nisnError = 'NISN hanya boleh berisi angka';
      });
      isValid = false;
    }
    
    // Validate email
    if (emailController.text.trim().isEmpty) {
      setState(() {
        _emailError = 'Email tidak boleh kosong';
      });
      isValid = false;
    } else if (!_isValidEmail(emailController.text.trim())) {
      setState(() {
        _emailError = 'Format email tidak valid';
      });
      isValid = false;
    }
    
    // Validate username
    if (userController.text.trim().isEmpty) {
      setState(() {
        _usernameError = 'Username tidak boleh kosong';
      });
      isValid = false;
    }
    
    // Validate password
    if (passController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password tidak boleh kosong';
      });
      isValid = false;
    } else if (passController.text.length < 6) {
      setState(() {
        _passwordError = 'Password minimal 6 karakter';
      });
      isValid = false;
    }
    
    // Validate confirm password
    if (confirmPassController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Konfirmasi password tidak boleh kosong';
      });
      isValid = false;
    } else if (confirmPassController.text != passController.text) {
      setState(() {
        _confirmPasswordError = 'Password tidak sama';
      });
      isValid = false;
    }
    
    // Jika semua valid, lanjutkan signup
    if (isValid) {
      _showLoadingDialog(context);
    }
  }
  
  // Email format validation
  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }
  
  // NISN validation (hanya angka)
  bool _isValidNISN(String nisn) {
    final nisnRegExp = RegExp(r'^[0-9]+$');
    return nisnRegExp.hasMatch(nisn);
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
                'Membuat Akun...',
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

    // Simulasi proses pendaftaran
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Tutup dialog loading
      
      // Tampilkan dialog sukses dengan pesan verifikasi siswa
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(
                Icons.verified_user,
                color: Color(0xFF1A5B9C),
                size: 28,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pendaftaran Berhasil!',
                  style: TextStyle(
                    color: Color(0xFF1A5B9C), 
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat! Anda terverifikasi sebagai siswa SMPN 11.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Akun Anda telah berhasil dibuat dan diverifikasi. Silakan login dengan akun baru Anda.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog sukses
                Navigator.of(context).pop(); // Kembali ke halaman login
              },
              child: const Text(
                'Login Sekarang',
                style: TextStyle(
                  color: Color(0xFF1A5B9C),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Particle model for background animation (sama dengan LoginPage)
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

// Custom painter for particle animation (sama dengan LoginPage)
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