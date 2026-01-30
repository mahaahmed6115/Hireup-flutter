import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          MaterialPageRoute(builder: (context) => const Onbordingscreen()),
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
          gradient: LinearGradient(
            colors: [
              Color(0xFF08423D),
              Color(0xFF0B6A4D),
              Color(0xFF5E8D5E),
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
                // اللوجو متكيف مع أي شاشة
                Image.asset(
                  "assets/images/splash-removebg-preview 1.png",
                  width: 220.w,
                  height: 220.h,
                ),
                SizedBox(height: 20.h),
                // اسم التطبيق مع text scaling
                Text(
                  "HireUp",
                  style: TextStyle(
                    fontSize: 32.sp, // متكيف مع الشاشة
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.w, // متكيف مع العرض
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
