import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "AI Professional Trainer",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= AI VISUAL =================
            Container(
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _buildAIVisualizer(primaryGreen),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryGreen.withOpacity(0.35),
                          blurRadius: 40.r,
                          spreadRadius: 5.r,
                        ),
                      ],
                    ),
                    child: Icon(
                      isSpeaking ? Icons.hearing : Icons.psychology,
                      color: primaryGreen,
                      size: 60.sp,
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Column(
                      children: [
                        Text(
                          "Interviewer is $aiStatus",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          aiHint,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================= LIVE ANALYSIS =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.02),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25.r),
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
                    SizedBox(height: 14.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: confidenceLevel,
                        minHeight: 7.h,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(primaryGreen),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ================= QUESTION =================
            Container(
              margin: EdgeInsets.only(top: 25.h),
              padding: EdgeInsets.fromLTRB(28.w, 28.h, 28.w, 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
              ),
              child: Column(
                children: [
                  Text(
                    "Behavioral Interview",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Question 3 of 10",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  LinearProgressIndicator(
                    value: 0.3,
                    minHeight: 5.h,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(primaryGreen),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "How do you handle conflict within a development team?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 34.h),
                  _micButton(primaryGreen, darkGreen),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _goToFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      "See Feedback",
                      style: TextStyle(
                        color: darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Tap and hold mic to record your answer",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
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
              width: 140.w + i * 50.w + _waveController.value * 30.w,
              height: 140.h + i * 50.h + _waveController.value * 30.h,
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
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(color: Colors.white70, fontSize: 11.sp),
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
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [dark, light]),
          boxShadow: [BoxShadow(color: light.withOpacity(0.4), blurRadius: 25.r)],
        ),
        child: Icon(
          isSpeaking ? Icons.graphic_eq : Icons.mic,
          color: Colors.white,
          size: 38.sp,
        ),
      ),
    );
  }
}
