import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'dart:math' as math;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  
  // Particles for background
  final List<ParticleModel> _particles = List.generate(
    20,
    (_) => ParticleModel.random(),
  );

  @override
  void initState() {
    super.initState();
    
    // Set system UI for immersive experience
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0A1128),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background - Tetap sama seperti permintaan
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
            size: Size(size.width, size.height),
            painter: ParticlesPainter(_particles, _rotateController),
          ),
          
          // Main Content dengan Layout Profesional
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bagian atas dengan logo
                  const SizedBox(height: 48),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _floatingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 3 * math.sin(_floatingAnimation.value * math.pi)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo dengan efek 3D yang lebih halus
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Logo shadow dengan efek blur
                                    AnimatedBuilder(
                                      animation: _rotateController,
                                      builder: (context, child) {
                                        return Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()
                                            ..setEntry(3, 2, 0.0007)
                                            ..rotateX(0.07 * math.sin(_rotateController.value * math.pi))
                                            ..rotateY(0.07 * math.cos(_rotateController.value * math.pi)),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.15),
                                              borderRadius: BorderRadius.circular(35),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue.withOpacity(0.2),
                                                  blurRadius: 30,
                                                  spreadRadius: 1,
                                                )
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.school,
                                              size: 75,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Text logo dengan efek modern
                                const _3DText(text: "ElevenPlan"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Tagline dalam card dengan design profesional
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 0.8 + 0.2 * _pulseController.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.08),
                                    blurRadius: 20,
                                    spreadRadius: -5,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Rencanakan harimu,\nTaklukkan mimpimu.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1.6,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Belajar jadi seru, tugas jadi teratur.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.8),
                                      height: 1.4,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Spacer untuk layout yang lebih proporsional
                  const SizedBox(height: 40),
                  
                  // Login Button dengan design premium
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1A7CE8).withOpacity(0.3 + 0.2 * _pulseController.value),
                                blurRadius: 20,
                                spreadRadius: -5,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Haptic feedback for button press
                              HapticFeedback.mediumImpact();
                              
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, animation, __) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: const LoginPage(),
                                    );
                                  },
                                  transitionDuration: const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1A5B9C),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'MASUK',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 18),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Footer section with brand identity
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      'v1.0 • Solusi Manajemen Belajar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Floating Elements yang lebih profesional
          _buildFloatingElement(
            left: size.width * 0.1,
            top: size.height * 0.2,
            icon: Icons.calendar_today,
            animation: _floatingController,
          ),
          _buildFloatingElement(
            right: size.width * 0.15,
            bottom: size.height * 0.25,
            icon: Icons.task_alt,
            animation: _floatingController,
            delay: 0.5,
          ),
          _buildFloatingElement(
            right: size.width * 0.2,
            top: size.height * 0.22,
            icon: Icons.auto_graph,
            animation: _floatingController,
            delay: 0.25,
          ),
          _buildFloatingElement(
            left: size.width * 0.25,
            bottom: size.height * 0.28,
            icon: Icons.lightbulb_outline,
            animation: _floatingController,
            delay: 0.75,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFloatingElement({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required IconData icon,
    required AnimationController animation,
    double delay = 0.0,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final value = (animation.value + delay) % 1.0;
          return Transform.translate(
            offset: Offset(
              6 * math.sin(value * 2 * math.pi),
              6 * math.cos(value * 2 * math.pi),
            ),
            child: Opacity(
              opacity: 0.4 + 0.2 * math.sin(value * 2 * math.pi),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom 3D Text Widget yang diperbarui
class _3DText extends StatelessWidget {
  final String text;
  
  const _3DText({required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shadow layers for 3D effect - lebih halus
        for (int i = 1; i <= 6; i++)
          Positioned(
            left: i * 0.4,
            top: i * 0.4,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A5B9C).withOpacity(0.2 / i),
                letterSpacing: 1.5,
              ),
            ),
          ),
          
        // Main text with gradient
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.white,
              const Color(0xFFF8ECAE6),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        
        // Highlight layer
        Positioned(
          top: 1.5,
          left: 1.5,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.3),
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
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