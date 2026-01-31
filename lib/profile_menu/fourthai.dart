import 'package:flutter/material.dart';
import 'package:hireup/profile_menu/fifthai.dart' show FeedbackScreen;

class AIInterviewScreen extends StatefulWidget {
  const AIInterviewScreen({super.key});

  @override
  State<AIInterviewScreen> createState() => _AIInterviewScreenState();
}

class _AIInterviewScreenState extends State<AIInterviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  bool isSpeaking = false;
  String aiStatus = "Thinking";
  String aiHint = "Preparing next question...";
  double confidenceLevel = 0.65;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _goToFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeedbackScreen(
          confidence: confidenceLevel,
          keywordMatch: 0.7,
          sentiment: "Positive",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkGreen = Color(0xFF0B6A4D);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "AI Professional Trainer",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// ================= AI VISUAL =================
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildAIVisualizer(primaryGreen),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.35),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    isSpeaking ? Icons.hearing : Icons.psychology,
                    color: primaryGreen,
                    size: 60,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: Column(
                    children: [
                      Text(
                        "Interviewer is $aiStatus",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        aiHint,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ================= LIVE ANALYSIS =================
          Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _metric("Confidence", "88%", primaryGreen),
                    _metric("Keywords", "72%", Colors.blue),
                    _metric("Sentiment", "Positive", Colors.orange),
                  ],
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: confidenceLevel,
                    minHeight: 7,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(primaryGreen),
                  ),
                ),
              ],
            ),
          ),

          /// ================= QUESTION =================
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 15), // رفعنا Container الأبيض
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Behavioral Interview",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Question 3 of 10",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.3,
                      minHeight: 5,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(primaryGreen),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "How do you handle conflict within a development team?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 34),
                    _micButton(primaryGreen, darkGreen),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _goToFeedback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "See Feedback",
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Tap and hold mic to record your answer",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= COMPONENTS =================

  Widget _buildAIVisualizer(Color color) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(3, (i) {
            return Container(
              width: 140 + i * 50 + _waveController.value * 30,
              height: 140 + i * 50 + _waveController.value * 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.25)),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _metric(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Widget _micButton(Color light, Color dark) {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          isSpeaking = true;
          aiStatus = "Listening";
          aiHint = "Analyzing your voice...";
          confidenceLevel = 0.9;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          isSpeaking = false;
          aiStatus = "Evaluating";
          aiHint = "Generating feedback...";
          confidenceLevel = 0.65;
        });
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [dark, light]),
          boxShadow: [BoxShadow(color: light.withOpacity(0.4), blurRadius: 25)],
        ),
        child: Icon(
          isSpeaking ? Icons.graphic_eq : Icons.mic,
          color: Colors.white,
          size: 38,
        ),
      ),
    );
  }
}
