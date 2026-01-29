import 'package:flutter/material.dart';

class Secondsc extends StatelessWidget {
  const Secondsc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B6A4D), // نفس الأخضر الفخم الموحد
      child: Column(
        children: [
          const SizedBox(height: 80),
          // قسم الصورة
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset(
                "assets/images/disabled student-bro.png",
                fit: BoxFit.contain,
              ),
            ),
          ),

          // قسم النص (العلبة البيضاء)
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80), // انحناء مميز لليمين
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    "Tailored\nOpportunities.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1D3D),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "An inclusive job market. Choose the working environment that inspires and supports you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1.6,
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
