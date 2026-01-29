import 'package:flutter/material.dart';

class Thirdsc extends StatelessWidget {
  const Thirdsc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B6A4D),
      child: Column(
        children: [
          const SizedBox(height: 80),
          // قسم الصورة الأخيرة
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset(
                "assets/images/Pic3 2.png",
                fit: BoxFit.contain,
              ),
            ),
          ),

          // قسم النص الأخير
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    "READY TO\nGET STARTED?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1D3D),
                      height: 1.2,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Simple steps stand between you and your dream job. Let's begin your journey with HireUp today.",
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
