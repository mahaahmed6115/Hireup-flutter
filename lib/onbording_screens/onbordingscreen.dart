import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          /// الصفحات
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: const [Firstsc(), Secondsc(), Thirdsc()],
          ),

          /// زر Skip
          if (_currentIndex < 2)
            Positioned(
              top: 50.h,
              right: 20.w,
              child: TextButton(
                onPressed: () => _pageController.jumpToPage(2),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),

          /// الجزء السفلي
          Positioned(
            bottom: 40.h,
            left: 30.w,
            right: 30.w,
            child: Column(
              children: [
                /// Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _totalPages,
                        (index) => _buildDot(index),
                  ),
                ),

                SizedBox(height: 40.h),

                /// Button
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
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: _currentIndex == index ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? const Color(0xff35CA60)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  Widget _buildMainButton() {
    bool isLastPage = _currentIndex == _totalPages - 1;

    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff35CA60),
              Color(0xFF0B6A4D),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff35CA60).withOpacity(0.4),
              blurRadius: 12.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (isLastPage) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
              );
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Text(
            isLastPage ? "GET STARTED" : "NEXT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2.w,
            ),
          ),
        ),
      ),
    );
  }
}
