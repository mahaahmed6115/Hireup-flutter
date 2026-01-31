import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text(
          "Interview Feedback",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // ===== TITLE =====
            Text(
              "Your Performance Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "Review your answers and improve for next time.",
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),

            SizedBox(height: 30.h),

            // ===== METRICS =====
            _buildMetric("Confidence", confidence, primaryGreen),
            SizedBox(height: 18.h),
            _buildMetric("Keyword Match", keywordMatch, Colors.blue),
            SizedBox(height: 18.h),
            _buildSentiment(sentiment),

            SizedBox(height: 30.h),

            // ===== TIPS / SUGGESTIONS =====
            Text(
              "Suggestions for Improvement",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _buildTip("Speak more confidently and clearly."),
            _buildTip("Use keywords relevant to the question."),
            _buildTip("Structure answers using STAR method."),
            Spacer(),

            // ===== BUTTONS =====
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // ارجع للانترفيو أو الصفحة السابقة
                },
                child: Text(
                  "Back to Interviews",
                  style: TextStyle(
                    fontSize: 16.sp,
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
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8.h,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "${(value * 100).toInt()}%",
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12.sp),
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
        Icon(icon, color: color, size: 28.sp),
        SizedBox(width: 12.w),
        Text(
          "Sentiment: $sentiment",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white70, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(color: Colors.white70, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
