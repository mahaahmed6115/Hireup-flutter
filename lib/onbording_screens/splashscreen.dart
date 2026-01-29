import 'package:flutter/material.dart';
import 'package:hireup/onbording_screens/onbordingscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد الـ Animation عشان اللوجو يظهر بالتدريج (Fade In)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // الانتقال للصفحة التالية بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onbordingscreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // تدرج ألوان أنعم وأشيك متناسق مع هوية HireUp
          gradient: LinearGradient(
            colors: [
              Color(0xFF08423D),
              Color(0xFF0B6A4D),
              Color(0xFF5E8D5E), // لون أخضر فاتح لكسر الحدة
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // اللوجو بتاعك مع تظبيط المقاس
                Image.asset(
                  "assets/images/splash-removebg-preview 1.png",
                  width: 220,
                  height: 220,
                ),
                const SizedBox(height: 20),
                // ممكن نضيف اسم التطبيق تحت اللوجو بشكل شيك
                const Text(
                  "HireUp",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
