import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  final double confidence;
  final double keywordMatch;
  final String sentiment;

  const FeedbackScreen({
    super.key,
    required this.confidence,
    required this.keywordMatch,
    required this.sentiment,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xff35CA60);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Interview Feedback",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ===== TITLE =====
            const Text(
              "Your Performance Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Review your answers and improve for next time.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 30),

            // ===== METRICS =====
            _buildMetric("Confidence", confidence, primaryGreen),
            const SizedBox(height: 18),
            _buildMetric("Keyword Match", keywordMatch, Colors.blue),
            const SizedBox(height: 18),
            _buildSentiment(sentiment),

            const SizedBox(height: 30),

            // ===== TIPS / SUGGESTIONS =====
            const Text(
              "Suggestions for Improvement",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTip("Speak more confidently and clearly."),
            _buildTip("Use keywords relevant to the question."),
            _buildTip("Structure answers using STAR method."),
            const Spacer(),

            // ===== BUTTONS =====
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // ارجع للانترفيو أو الصفحة السابقة
                },
                child: const Text(
                  "Back to Interviews",
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
    );
  }

  Widget _buildMetric(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${(value * 100).toInt()}%",
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSentiment(String sentiment) {
    Color color;
    IconData icon;

    switch (sentiment) {
      case "Positive":
        color = Colors.green;
        icon = Icons.sentiment_satisfied;
        break;
      case "Negative":
        color = Colors.red;
        icon = Icons.sentiment_dissatisfied;
        break;
      default:
        color = Colors.orange;
        icon = Icons.sentiment_neutral;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Text(
          "Sentiment: $sentiment",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
