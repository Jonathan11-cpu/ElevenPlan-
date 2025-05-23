import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'matematika_page.dart';
import 'bahasa_inggris_page.dart';
import 'ipa_page.dart';
import 'ips_page.dart';
import 'b_jawa_page.dart';
import 'agama_page.dart';
import 'seni_page.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> notifications = const [
    {
      'nama': 'Matematika',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran Matematika.',
      'page': MatematikaPage(),
    },
    {
      'nama': 'Bahasa Inggris',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran Bahasa Inggris.',
      'page': BahasaInggrisPage(),
    },
    {
      'nama': 'IPA',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran IPA.',
      'page': IpaPage(),
    },
    {
      'nama': 'IPS',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran IPS.',
      'page': IpsPage(),
    },
    {
      'nama': 'B. Jawa',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran Bahasa Jawa.',
      'page': BJawaPage(),
    },
    {
      'nama': 'Agama',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran Agama.',
      'page': AgamaPage(),
    },
    {
      'nama': 'Seni',
      'kalimat': 'Tugas baru telah ditambahkan pada mata pelajaran Seni.',
      'page': SeniPage(),
    },
  ];

  late final AnimationController _headerAnimationController;
  late final Animation<double> _headerAnimation;
  late final List<AnimationController> _itemAnimationControllers;
  late final List<Animation<double>> _itemAnimations;
  List<bool> _readStatus = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize read status for all notifications
    _readStatus = List.generate(notifications.length, (_) => false);
    
    // Header animation
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _headerAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
    );
    
    // Item animations
    _itemAnimationControllers = List.generate(
      notifications.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400 + (index * 100)),
        vsync: this,
      ),
    );
    
    _itemAnimations = _itemAnimationControllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutQuart,
            ))
        .toList();
    
    // Start animations
    _headerAnimationController.forward();
    
    for (int i = 0; i < _itemAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 200 + (i * 100)), () {
        if (mounted) {
          _itemAnimationControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _markAllAsRead() {
    setState(() {
      _readStatus = List.generate(notifications.length, (_) => true);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Semua notifikasi telah ditandai sebagai dibaca',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1565C0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  void _toggleReadStatus(int index) {
    setState(() {
      _readStatus[index] = !_readStatus[index];
    });
  }

  void _navigateToSubjectPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Box with Animation
          FadeTransition(
            opacity: _headerAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: Offset.zero,
              ).animate(_headerAnimation),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0D47A1).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Pemberitahuan Terbaru',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Text(
                            '${notifications.length}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Halaman ini menampilkan notifikasi tugas baru dari berbagai mata pelajaran',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.3,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: _markAllAsRead,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xFFE3F2FD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_outline_rounded,
                              color: Color(0xFF0D47A1),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Tandai Semua Dibaca',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xFF0D47A1),
                                letterSpacing: 0.2,
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
          ),
          
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                
                return ScaleTransition(
                  scale: _itemAnimations[index],
                  child: FadeTransition(
                    opacity: _itemAnimations[index],
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: _readStatus[index] ? Colors.white.withOpacity(0.8) : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(_readStatus[index] ? 0.03 : 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: _readStatus[index] 
                              ? Colors.grey.withOpacity(0.2) 
                              : const Color(0xFF1976D2).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          // Show ripple animation
                          HapticFeedback.lightImpact();
                          
                          // Mark as read
                          setState(() {
                            _readStatus[index] = true;
                          });
                          
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) { // Use a separate dialogContext
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(
                                  'Buka Halaman Tugas ${notif['nama']}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        getIconForSubject(notif['nama']),
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Apakah Anda ingin membuka halaman tugas untuk mata pelajaran ${notif['nama']}?',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: [
                                  // Cancel Button
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                  
                                  // Continue Button with gradient
                                  Container(
                                    margin: const EdgeInsets.only(left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF1976D2).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Close the dialog first
                                        Navigator.of(dialogContext).pop();
                                        
                                        // Show snackbar with bounce animation
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Membuka halaman mata pelajaran ${notif['nama']}',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          duration: const Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: const Color(0xFF1976D2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          margin: const EdgeInsets.all(12),
                                        );
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        
                                        // Navigate after a brief delay
                                        Future.delayed(const Duration(milliseconds: 800), () {
                                          if (mounted) {
                                            // Use the proper navigation function to go to the page
                                            _navigateToSubjectPage(context, notif['page']);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                leading: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: _readStatus[index]
                                          ? [Colors.grey.shade200, Colors.grey.shade300]
                                          : [const Color(0xFF1976D2), const Color(0xFF42A5F5)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _readStatus[index]
                                            ? Colors.grey.withOpacity(0.2) 
                                            : const Color(0xFF1976D2).withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    getIconForSubject(notif['nama']),
                                    color: _readStatus[index] ? Colors.grey.shade600 : Colors.white,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  notif['kalimat'],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: _readStatus[index] ? FontWeight.normal : FontWeight.w500,
                                    fontSize: 14.5,
                                    color: _readStatus[index] 
                                        ? Colors.grey.shade700 
                                        : const Color(0xFF0D47A1),
                                    height: 1.3,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    'Mata Pelajaran: ${notif['nama']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: _readStatus[index] ? Colors.grey : Colors.grey.shade700,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _toggleReadStatus(index),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: _readStatus[index] 
                                              ? Colors.grey.shade200 
                                              : const Color(0xFFE3F2FD),
                                          borderRadius: BorderRadius.circular(17),
                                          border: Border.all(
                                            color: _readStatus[index]
                                                ? Colors.grey.shade300
                                                : const Color(0xFF1976D2).withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          _readStatus[index] ? Icons.check_rounded : Icons.circle_outlined,
                                          size: 18,
                                          color: _readStatus[index] 
                                              ? Colors.grey.shade600 
                                              : const Color(0xFF1976D2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                        begin: 0,
                                        end: _readStatus[index] ? 0 : math.pi * 2,
                                      ),
                                      duration: const Duration(milliseconds: 1500),
                                      curve: Curves.elasticOut,
                                      builder: (context, value, child) {
                                        return Transform.rotate(
                                          angle: value * 0.1,
                                          child: Transform.scale(
                                            scale: _readStatus[index] ? 0.9 : 1.0,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16,
                                              color: _readStatus[index] 
                                                  ? Colors.grey.shade400 
                                                  : const Color(0xFF0D47A1),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Red circle indicator for unread notifications
                            if (!_readStatus[index])
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.3),
                                        blurRadius: 4,
                                        spreadRadius: 1,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  IconData getIconForSubject(String subject) {
    switch (subject) {
      case 'Matematika':
        return Icons.calculate_rounded;
      case 'Bahasa Inggris':
        return Icons.language_rounded; 
      case 'IPA':
        return Icons.science_rounded;
      case 'IPS':
        return Icons.public_rounded;
      case 'B. Jawa':
        return Icons.translate_rounded;
      case 'Agama':
        return Icons.church_rounded;
      case 'Seni':
        return Icons.brush_rounded;
      default:
        return Icons.book_rounded;
    }
  }
}