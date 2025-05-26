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
  late AnimationController _slideController;
  late Animation<double> _floatingAnimation;
  late Animation<Offset> _slideAnimation;
  
  final List<ParticleModel> _particles = List.generate(15, (_) => ParticleModel.random());

  @override
  void initState() {
    super.initState();
    
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
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _floatingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.elasticOut));
    
    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _floatingController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.height < 700;
    final bool isTinyScreen = size.height < 600;
    
    return Scaffold(
      body: Stack(
        children: [
          // Original Gradient Background
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
          
          // Main Content with SingleChildScrollView for overflow protection
          SafeArea(
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Header Section - Logo dan Brand Name
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: isTinyScreen ? 16 : (isSmallScreen ? 20 : 32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo Section with Asset Integration
                              AnimatedBuilder(
                                animation: _floatingAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, 8 * math.sin(_floatingAnimation.value * math.pi)),
                                    child: _buildLogoSection(isTinyScreen, isSmallScreen),
                                  );
                                },
                              ),
                              
                              SizedBox(height: isTinyScreen ? 12 : (isSmallScreen ? 16 : 24)),
                              
                              // Brand Name with Enhanced Typography
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: 0.9 + 0.1 * _pulseController.value,
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (bounds) => LinearGradient(
                                        colors: [
                                          Colors.white,
                                          const Color(0xFFE8F4FD),
                                          Colors.white70,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: Text(
                                        'ElevenPlan',
                                        style: TextStyle(
                                          fontSize: isTinyScreen ? 28 : (isSmallScreen ? 32 : 38),
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                          height: 1.1,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              
                              SizedBox(height: isTinyScreen ? 4 : 8),
                              
                              // Subtitle
                              Text(
                                'Smart Study Planner',
                                style: TextStyle(
                                  fontSize: isTinyScreen ? 12 : (isSmallScreen ? 13 : 15),
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Content Section - Feature Cards dan Tagline
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Feature Cards
                                Row(
                                  children: [
                                    Expanded(child: _buildFeatureCard(Icons.calendar_today, 'Jadwal', isTinyScreen)),
                                    const SizedBox(width: 10),
                                    Expanded(child: _buildFeatureCard(Icons.task_alt, 'Tugas', isTinyScreen)),
                                    const SizedBox(width: 10),
                                    Expanded(child: _buildFeatureCard(Icons.trending_up, 'Progress', isTinyScreen)),
                                  ],
                                ),
                                
                                SizedBox(height: isTinyScreen ? 16 : (isSmallScreen ? 20 : 24)),
                                
                                // Main Tagline Card
                                AnimatedBuilder(
                                  animation: _pulseController,
                                  builder: (context, child) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(isTinyScreen ? 16 : (isSmallScreen ? 18 : 22)),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.15),
                                            Colors.white.withOpacity(0.08),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.1 + 0.05 * _pulseController.value),
                                            blurRadius: 20,
                                            spreadRadius: -6,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Rencanakan Harimu,\nTaklukkan Mimpimu',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: isTinyScreen ? 14 : (isSmallScreen ? 16 : 18),
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              height: 1.3,
                                              letterSpacing: 0.4,
                                            ),
                                          ),
                                          SizedBox(height: isTinyScreen ? 6 : 8),
                                          Text(
                                            'Belajar jadi seru, tugas jadi teratur,\nimpian jadi nyata.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: isTinyScreen ? 11 : (isSmallScreen ? 12 : 13),
                                              color: Colors.white.withOpacity(0.85),
                                              height: 1.4,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Action Section - Tombol dan Footer
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 28 : 36,
                            vertical: isTinyScreen ? 16 : (isSmallScreen ? 20 : 24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Login Button
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return Container(
                                    width: double.infinity,
                                    height: isTinyScreen ? 48 : (isSmallScreen ? 50 : 54),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          const Color(0xFFF8F9FA),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.25 + 0.15 * _pulseController.value),
                                          blurRadius: 18,
                                          spreadRadius: -4,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
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
                                            transitionDuration: const Duration(milliseconds: 600),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: const Color(0xFF1A5B9C),
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MULAI SEKARANG',
                                            style: TextStyle(
                                              fontSize: isTinyScreen ? 12 : (isSmallScreen ? 13 : 15),
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Icon(Icons.arrow_forward_rounded, size: isTinyScreen ? 16 : 18),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              
                              SizedBox(height: isTinyScreen ? 12 : 16),
                              
                              // Footer
                              Text(
                                'v1.0 • Smart Study Management Solution',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isTinyScreen ? 9 : 10,
                                  color: Colors.white.withOpacity(0.6),
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Floating Elements
          _buildFloatingElements(size),
        ],
      ),
    );
  }
  
  Widget _buildLogoSection(bool isTinyScreen, bool isSmallScreen) {
    final logoSize = isTinyScreen ? 80.0 : (isSmallScreen ? 100.0 : 120.0);
    final iconSize = isTinyScreen ? 50.0 : (isSmallScreen ? 65.0 : 75.0);
    
    return Container(
      width: logoSize,
      height: logoSize,
      child: AnimatedBuilder(
        animation: _rotateController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0007)
              ..rotateX(0.07 * math.sin(_rotateController.value * math.pi))
              ..rotateY(0.07 * math.cos(_rotateController.value * math.pi)),
            child: Container(
              padding: EdgeInsets.all(isTinyScreen ? 14 : (isSmallScreen ? 16 : 20)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(isTinyScreen ? 25 : (isSmallScreen ? 30 : 35)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 25,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'asset/jimeng-2025-05-25-777-_Buatkan logo modern, profesional, dan simpel untuk brand bernama elevenplan. ....jpeg',
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.school,
                      size: iconSize,
                      color: Colors.white70,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildFeatureCard(IconData icon, String label, bool isTinyScreen) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: isTinyScreen ? 12 : 14,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.05),
                blurRadius: 12,
                spreadRadius: -3,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: isTinyScreen ? 22 : 26),
              SizedBox(height: isTinyScreen ? 6 : 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTinyScreen ? 10 : 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildFloatingElements(Size size) {
    return Stack(
      children: [
        _buildFloatingElement(
          left: size.width * 0.1, top: size.height * 0.15,
          icon: Icons.auto_graph, animation: _floatingController,
        ),
        _buildFloatingElement(
          right: size.width * 0.12, bottom: size.height * 0.3,
          icon: Icons.lightbulb_outline, animation: _floatingController, delay: 0.3,
        ),
        _buildFloatingElement(
          right: size.width * 0.15, top: size.height * 0.18,
          icon: Icons.insights, animation: _floatingController, delay: 0.6,
        ),
        _buildFloatingElement(
          left: size.width * 0.2, bottom: size.height * 0.32,
          icon: Icons.psychology, animation: _floatingController, delay: 0.9,
        ),
      ],
    );
  }
  
  Widget _buildFloatingElement({
    double? left, double? right, double? top, double? bottom,
    required IconData icon, required AnimationController animation, double delay = 0.0,
  }) {
    return Positioned(
      left: left, right: right, top: top, bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final value = (animation.value + delay) % 1.0;
          return Transform.translate(
            offset: Offset(
              4 * math.sin(value * 2 * math.pi),
              4 * math.cos(value * 2 * math.pi),
            ),
            child: Opacity(
              opacity: 0.3 + 0.2 * math.sin(value * 2 * math.pi),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParticleModel {
  double x, y, size, speed, opacity;
  
  ParticleModel({required this.x, required this.y, required this.size, required this.speed, required this.opacity});
  
  factory ParticleModel.random() {
    return ParticleModel(
      x: math.Random().nextDouble(),
      y: math.Random().nextDouble(),
      size: math.Random().nextDouble() * 3 + 1,
      speed: math.Random().nextDouble() * 0.01 + 0.003,
      opacity: math.Random().nextDouble() * 0.3 + 0.1,
    );
  }
  
  void update() {
    y += speed;
    if (y > 1) {
      y = 0;
      x = math.Random().nextDouble();
      size = math.Random().nextDouble() * 3 + 1;
      opacity = math.Random().nextDouble() * 0.3 + 0.1;
    }
  }
}

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
        particle.size, paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}