import 'package:flutter/material.dart';
import 'dart:math' as math;

class VisualPage extends StatefulWidget {
  const VisualPage({super.key});

  @override
  State<VisualPage> createState() => _VisualPageState();
}

class _VisualPageState extends State<VisualPage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    {
      'story': 'Poster adalah media visual yang sangat efektif untuk menyampaikan pesan kepada khalayak luas. Poster biasanya dipasang di tempat-tempat strategis agar mudah dilihat oleh banyak orang.',
      'question': 'Poster biasanya digunakan untuk…',
      'options': [
        'Menceritakan kisah',
        'Mempromosikan atau memberikan informasi',
        'Menjelaskan langkah kerja',
        'Membuat teka-teki'
      ],
      'answer': 'Mempromosikan atau memberikan informasi',
    },
    {
      'story': 'Komik adalah media visual yang menggabungkan gambar dan teks untuk menceritakan sebuah cerita. Komik memiliki beberapa unsur penting yang membuatnya menarik dan mudah dipahami.',
      'question': 'Salah satu unsur penting dalam komik adalah…',
      'options': ['Diagram', 'Narasi panjang', 'Dialog balon', 'Grafik'],
      'answer': 'Dialog balon',
    },
    {
      'story': 'Gambar ilustrasi sering digunakan dalam buku, majalah, atau artikel untuk mendukung teks yang ada. Ilustrasi membantu pembaca memahami isi bacaan dengan lebih baik.',
      'question': 'Gambar ilustrasi bertujuan untuk…',
      'options': ['Menghitung nilai', 'Menghibur dengan gambar', 'Memperjelas teks', 'Menampilkan data'],
      'answer': 'Memperjelas teks',
    },
    {
      'story': 'Dalam dunia pendidikan modern, guru menggunakan berbagai media visual untuk membantu siswa memahami materi pelajaran. Media visual dapat membuat pembelajaran lebih menarik dan efektif.',
      'question': 'Media visual yang sering digunakan dalam pembelajaran adalah…',
      'options': ['Audio book', 'Infografis', 'Podcast', 'Cerpen'],
      'answer': 'Infografis',
    },
    {
      'story': 'Iklan visual yang baik harus mampu menarik perhatian target audience dalam waktu singkat. Desain yang menarik dan pesan yang jelas adalah kunci kesuksesan sebuah iklan visual.',
      'question': 'Ciri utama iklan visual yang baik adalah…',
      'options': [
        'Penuh tulisan dan tidak berwarna',
        'Singkat, jelas, dan menarik secara visual',
        'Hanya menggunakan teks',
        'Menghindari warna mencolok'
      ],
      'answer': 'Singkat, jelas, dan menarik secara visual',
    },
  ];

  int correctAnswers = 0;
  List<String?> selectedAnswers = List.filled(5, null);
  List<bool> questionSubmitted = List.filled(5, false);
  late final ScrollController scrollController;
  late final List<AnimationController> cardControllers;
  late final List<Animation<double>> cardAnimations;
  
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    
    // Initialize animations for each question card
    cardControllers = List.generate(
      questions.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 700 + (index * 100)),
        vsync: this,
      )
    );
    
    cardAnimations = cardControllers.map((controller) => 
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      )
    ).toList();
    
    // Start animations with a staggered effect
    Future.delayed(const Duration(milliseconds: 100), () {
      for (var i = 0; i < cardControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 150), () {
          cardControllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (var controller in cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void checkAnswer(int questionIndex) {
    setState(() {
      if (selectedAnswers[questionIndex] == questions[questionIndex]['answer']) {
        correctAnswers++;
      }
      questionSubmitted[questionIndex] = true;
    });
    
    // Scroll to next question
    if (questionIndex < questions.length - 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        scrollController.animateTo(
          (questionIndex + 1) * 450.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    } else {
      // Show results when all questions are answered
      Future.delayed(const Duration(milliseconds: 500), () {
        _showResultDialog();
      });
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultDialog(
        correctAnswers: correctAnswers,
        totalQuestions: questions.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tugas Visual",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  "$correctAnswers/${questions.length}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16.0),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            
            return ScaleTransition(
              scale: cardAnimations[index],
              child: QuestionCard(
                questionNumber: index + 1,
                story: question['story'],
                question: question['question'],
                options: question['options'],
                correctAnswer: question['answer'],
                selectedAnswer: selectedAnswers[index],
                isSubmitted: questionSubmitted[index],
                onSelect: (value) {
                  if (!questionSubmitted[index]) {
                    setState(() => selectedAnswers[index] = value);
                  }
                },
                onSubmit: () => checkAnswer(index),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool allAnswered = !questionSubmitted.contains(false);
          if (allAnswered) {
            _showResultDialog();
          } else {
            // Find first unanswered question
            int nextIndex = questionSubmitted.indexOf(false);
            if (nextIndex >= 0) {
              scrollController.animateTo(
                nextIndex * 450.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.assessment),
        tooltip: 'Lihat Hasil',
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final int questionNumber;
  final String story;
  final String question;
  final List<dynamic> options;
  final String correctAnswer;
  final String? selectedAnswer;
  final bool isSubmitted;
  final Function(String) onSelect;
  final VoidCallback onSubmit;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.story,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.isSubmitted,
    required this.onSelect,
    required this.onSubmit,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> with SingleTickerProviderStateMixin {
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.elasticIn,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSubmitted && !oldWidget.isSubmitted) {
      _feedbackController.forward().then((_) => _feedbackController.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              color: Colors.deepOrange,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Text(
                      "${widget.questionNumber}",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Pertanyaan ${widget.questionNumber}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.isSubmitted)
                    ScaleTransition(
                      scale: _feedbackAnimation,
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: widget.selectedAnswer == widget.correctAnswer 
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.selectedAnswer == widget.correctAnswer 
                              ? Icons.check 
                              : Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Story section
            Container(
              color: Colors.orange.shade50,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Text(
                        "Materi Visual",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.story,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Question section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Text(
                        "Pertanyaan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...widget.options.map<Widget>((option) {
                    final isSelected = widget.selectedAnswer == option;
                    final isCorrect = widget.correctAnswer == option;
                    
                    Color? backgroundColor;
                    Color borderColor = Colors.grey.shade300;
                    Color textColor = Colors.black87;
                    
                    if (widget.isSubmitted) {
                      if (isCorrect) {
                        backgroundColor = Colors.green.shade50;
                        borderColor = Colors.green;
                        textColor = Colors.green.shade800;
                      } else if (isSelected) {
                        backgroundColor = Colors.red.shade50;
                        borderColor = Colors.red;
                        textColor = Colors.red.shade800;
                      }
                    } else if (isSelected) {
                      backgroundColor = Colors.orange.shade50;
                      borderColor = Colors.deepOrange;
                      textColor = Colors.deepOrange;
                    }
                    
                    return GestureDetector(
                      onTap: () {
                        if (!widget.isSubmitted) {
                          widget.onSelect(option);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? borderColor : Colors.grey.shade400,
                                  width: 2,
                                ),
                                color: isSelected ? borderColor : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (widget.isSubmitted && isCorrect)
                              Icon(Icons.check_circle, color: Colors.green),
                            if (widget.isSubmitted && isSelected && !isCorrect)
                              Icon(Icons.cancel, color: Colors.red),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  if (!widget.isSubmitted)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.selectedAnswer != null ? widget.onSubmit : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Kirim Jawaban",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (widget.isSubmitted)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.selectedAnswer == widget.correctAnswer
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: widget.selectedAnswer == widget.correctAnswer
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            widget.selectedAnswer == widget.correctAnswer
                                ? Icons.check_circle
                                : Icons.error,
                            color: widget.selectedAnswer == widget.correctAnswer
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.selectedAnswer == widget.correctAnswer
                                  ? "Jawaban benar! Bagus sekali."
                                  : "Jawaban kurang tepat. Jawaban yang benar adalah: ${widget.correctAnswer}",
                              style: TextStyle(
                                color: widget.selectedAnswer == widget.correctAnswer
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultDialog extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultDialog({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;
  late Animation<double> _badgeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scoreAnimation = Tween<double>(
      begin: 0,
      end: widget.correctAnswers.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _badgeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badges = widget.correctAnswers * 2;
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    String resultMessage;
    Color resultColor;
    IconData resultIcon;
    
    if (percentage >= 80) {
      resultMessage = "Luar Biasa!";
      resultColor = Colors.deepOrange;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      resultMessage = "Bagus!";
      resultColor = Colors.orange.shade600;
      resultIcon = Icons.thumb_up;
    } else {
      resultMessage = "Terus Berlatih!";
      resultColor = Colors.amber;
      resultIcon = Icons.school;
    }
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              resultMessage,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: resultColor,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: _scoreAnimation.value / widget.totalQuestions,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(resultColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${_scoreAnimation.value.toInt()}",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        Text(
                          "dari ${widget.totalQuestions}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            ScaleTransition(
              scale: _badgeAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 12,
                      child: Icon(Icons.star, color: Colors.amber, size: 30),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$badges Badge Diperoleh!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Motivational message
            Text(
              percentage >= 80
                  ? "Hebat! Pemahaman visual kamu sangat baik."
                  : percentage >= 60
                      ? "Kamu sudah memahami sebagian besar konsep visual. Terus berlatih!"
                      : "Jangan menyerah! Latihan terus untuk meningkatkan kemampuan visual.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(resultIcon),
                        const SizedBox(width: 8),
                        const Text(
                          "Tutup",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
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
}