import 'package:flutter/material.dart';
import 'package:hireup/profile_menu/thirdai.dart'; // شاشة الإعداد

class AITrainingIntroScreen extends StatelessWidget {
  const AITrainingIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ===== AI HEADER =====
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            primaryGreen.withOpacity(0.8),
                            primaryGreen.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.psychology,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "AI Interview Trainer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Train smarter. Perform better.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ===== FEATURES =====
              _featureCard(
                icon: Icons.psychology,
                title: "AI-Powered Interviews",
                desc:
                "Simulates real interviewers using artificial intelligence to evaluate your answers.",
              ),
              _featureCard(
                icon: Icons.graphic_eq,
                title: "Voice & Confidence Analysis",
                desc:
                "Analyzes your tone, confidence level, and clarity while you speak.",
              ),
              _featureCard(
                icon: Icons.auto_awesome,
                title: "Smart Feedback",
                desc:
                "Provides instant feedback and improvement tips after each answer.",
              ),
              _featureCard(
                icon: Icons.trending_up,
                title: "Progress Tracking",
                desc:
                "Tracks your performance and helps you improve with every session.",
              ),

              const SizedBox(height: 30),

              // ===== START BUTTON =====
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InterviewSetupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Start AI Training",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ===== FEATURE CARD =====
  Widget _featureCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff35CA60).withOpacity(0.15),
            ),
            child: Icon(icon, color: const Color(0xff35CA60)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
