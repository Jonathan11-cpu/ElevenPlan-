import 'package:flutter/material.dart';
import 'matematika_page.dart';
import 'bahasa_inggris_page.dart';
import 'ipa_page.dart';
import 'ips_page.dart';
import 'b_jawa_page.dart';
import 'agama_page.dart';
import 'seni_page.dart';
import 'subject_detail_page.dart';

class SemuaTugasPage extends StatefulWidget {
  const SemuaTugasPage({super.key});

  @override
  State<SemuaTugasPage> createState() => _SemuaTugasPageState();
}

class _SemuaTugasPageState extends State<SemuaTugasPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Daftar semua mata pelajaran termasuk yang sudah selesai
  final List<Map<String, dynamic>> allSubjects = const [
    // 7 mata pelajaran dari home (belum selesai semua)
    {'nama': 'Matematika', 'icon': Icons.calculate, 'tugas': 3, 'selesai': 1, 'isCompleted': false},
    {'nama': 'Bahasa Inggris', 'icon': Icons.language, 'tugas': 2, 'selesai': 0, 'isCompleted': false},
    {'nama': 'IPA', 'icon': Icons.science, 'tugas': 4, 'selesai': 1, 'isCompleted': false},
    {'nama': 'IPS', 'icon': Icons.public, 'tugas': 3, 'selesai': 1, 'isCompleted': false},
    {'nama': 'B. Jawa', 'icon': Icons.menu_book, 'tugas': 3, 'selesai': 0, 'isCompleted': false},
    {'nama': 'Agama', 'icon': Icons.church, 'tugas': 4, 'selesai': 2, 'isCompleted': false},
    {'nama': 'Seni', 'icon': Icons.palette, 'tugas': 5, 'selesai': 1, 'isCompleted': false},
    
    // 4 mata pelajaran tambahan (sudah selesai semua)
    {'nama': 'Prakarya', 'icon': Icons.build, 'tugas': 3, 'selesai': 3, 'isCompleted': true},
    {'nama': 'PPKN', 'icon': Icons.account_balance, 'tugas': 2, 'selesai': 2, 'isCompleted': true},
    {'nama': 'PJOK', 'icon': Icons.sports_soccer, 'tugas': 4, 'selesai': 4, 'isCompleted': true},
    {'nama': 'TIK', 'icon': Icons.computer, 'tugas': 3, 'selesai': 3, 'isCompleted': true},
  ];

  List<Map<String, dynamic>> get filteredSubjects {
    if (_searchQuery.isEmpty) {
      return allSubjects;
    }
    return allSubjects.where((subject) {
      return subject['nama'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  int get totalTugas {
    return allSubjects.fold(0, (sum, subject) => sum + (subject['tugas'] as int));
  }

  int get totalSelesai {
    return allSubjects.fold(0, (sum, subject) => sum + (subject['selesai'] as int));
  }

  int get totalBelumSelesai {
    return totalTugas - totalSelesai;
  }

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

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daftar Mata Pelajaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Card
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE3F2FD),
                          Color(0xFFBBDEFB),
                          Color(0xFFE1F5FE),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              color: Colors.blueGrey[600],
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Ringkasan Tugas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSummaryItem(
                              'Total Tugas',
                              totalTugas.toString(),
                              Icons.assignment_outlined,
                              const Color(0xFF1976D2),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.blueGrey[300],
                            ),
                            _buildSummaryItem(
                              'Selesai',
                              totalSelesai.toString(),
                              Icons.check_circle_outline,
                              Colors.green[600]!,
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.blueGrey[300],
                            ),
                            _buildSummaryItem(
                              'Belum Selesai',
                              totalBelumSelesai.toString(),
                              Icons.pending_outlined,
                              Colors.orange[600]!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari mata pelajaran...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[500]),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: const Color(0xFF1976D2), width: 1.5),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Section Header
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.blueGrey[700],
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Semua Mata Pelajaran',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                        letterSpacing: 0.8,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${filteredSubjects.length} mapel',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.w500,
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
                const SizedBox(height: 16),

                // Subject List
                Expanded(
                  child: filteredSubjects.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Tidak ada mata pelajaran yang ditemukan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Coba kata kunci yang berbeda',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredSubjects.length,
                          itemBuilder: (context, index) {
                            final subject = filteredSubjects[index];
                            String nama = subject['nama']!;
                            IconData icon = subject['icon']!;
                            int tugas = subject['tugas']!;
                            int selesai = subject['selesai']!;
                            bool isCompleted = subject['isCompleted']!;
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
                                  border: isCompleted
                                      ? Border.all(color: Colors.green[300]!, width: 1)
                                      : null,
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
                                                      gradient: LinearGradient(
                                                        colors: isCompleted
                                                            ? [
                                                                const Color(0xFFE8F5E8),
                                                                const Color(0xFFC8E6C9),
                                                              ]
                                                            : [
                                                                const Color(0xFFE3F2FD),
                                                                const Color(0xFFBBDEFB),
                                                              ],
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: (isCompleted
                                                                  ? Colors.green[300]!
                                                                  : const Color(0xFF1976D2))
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: const Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      icon,
                                                      size: 32,
                                                      color: isCompleted
                                                          ? Colors.green[700]
                                                          : const Color(0xFF0D47A1),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              nama,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                                color: isCompleted
                                                                    ? Colors.green[700]
                                                                    : const Color(0xFF0D47A1),
                                                                letterSpacing: 0.4,
                                                              ),
                                                            ),
                                                          ),
                                                          if (isCompleted)
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 4,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.green[100],
                                                                borderRadius: BorderRadius.circular(12),
                                                                border: Border.all(
                                                                  color: Colors.green[300]!,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Icon(
                                                                    Icons.check_circle,
                                                                    size: 12,
                                                                    color: Colors.green[700],
                                                                  ),
                                                                  const SizedBox(width: 4),
                                                                  Text(
                                                                    'Selesai',
                                                                    style: TextStyle(
                                                                      fontSize: 10,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.green[700],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
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
                                                                color: Colors.orange[700],
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            )
                                                          else
                                                            Text(
                                                              'Semua tugas selesai ($tugas/$tugas)',
                                                              style: TextStyle(
                                                                color: Colors.green[700],
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      // Progress bar
                                                      Container(
                                                        height: 6,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[200],
                                                          borderRadius: BorderRadius.circular(3),
                                                        ),
                                                        child: FractionallySizedBox(
                                                          alignment: Alignment.centerLeft,
                                                          widthFactor: tugas > 0 ? selesai / tugas : 0,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: isCompleted
                                                                    ? [Colors.green[400]!, Colors.green[600]!]
                                                                    : [Colors.blue[400]!, Colors.blue[600]!],
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                              ),
                                                              borderRadius: BorderRadius.circular(3),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: isCompleted
                                                        ? Colors.green[50]
                                                        : const Color(0xFFE3F2FD),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 16,
                                                    color: isCompleted
                                                        ? Colors.green[700]
                                                        : const Color(0xFF0D47A1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Badge for incomplete tasks
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
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}