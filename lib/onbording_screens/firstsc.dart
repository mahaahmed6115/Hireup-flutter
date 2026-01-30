import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Firstsc extends StatelessWidget {
  const Firstsc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B6A4D), // أخضر أغمق وأفخم
      child: Column(
        children: [
          SizedBox(height: 80.h), // متكيف مع الشاشة
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(30.w), // متكيف
              child: Image.asset(
                "assets/images/Pic1 1.png",
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: 30.w, vertical: 50.h), // متكيف
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Your Opportunity\nStarts Now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.sp, // متكيف
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1A1D3D),
                      height: 1.5.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "We believe every individual holds unique skills. Find the job that truly fits your abilities.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp, // متكيف
                      height: 1.6.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
