import 'package:flutter/material.dart';
import 'package:hireup/onbording_screens/firstsc.dart';
import 'package:hireup/onbording_screens/secondsc.dart';
import 'package:hireup/onbording_screens/thirdsc.dart';
import 'package:hireup/sign_in_screens/login.dart';

class Onbordingscreen extends StatefulWidget {
  const Onbordingscreen({super.key});

  @override
  State<Onbordingscreen> createState() => OnbordingscreenState();
}

class OnbordingscreenState extends State<Onbordingscreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. الصفحات الأساسية
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: const [Firstsc(), Secondsc(), Thirdsc()],
          ),

          // 2. زرار الـ Skip (بيظهر في أول صفحتين بس)
          if (_currentIndex < 2)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () => _pageController.jumpToPage(2),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

          // 3. الجزء السفلي (النقط والزراير)
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Column(
              children: [
                // النقط التفاعلية (Expanding Dots)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _totalPages,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 40),

                // الزرار الديناميكي المعدل باللونين
                _buildMainButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? const Color(0xff35CA60)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildMainButton() {
    bool isLastPage = _currentIndex == _totalPages - 1;
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Container(
        // إضافة التدرج اللوني (Gradient) للزرار
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff35CA60), // الأخضر الفاتح
              Color(0xFF0B6A4D), // الأخضر الغامق
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff35CA60).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (isLastPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => const Login()),
              );
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // شفاف ليظهر الـ Gradient
            shadowColor: Colors.transparent, // إخفاء ظل الزرار الافتراضي
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            isLastPage ? "GET STARTED" : "NEXT",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
