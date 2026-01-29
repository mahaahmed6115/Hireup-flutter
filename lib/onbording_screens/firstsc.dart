import 'package:flutter/material.dart';

class Firstsc extends StatelessWidget {
  const Firstsc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B6A4D), // أخضر أغمق وأفخم
      child: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                "assets/images/Pic1 1.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
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
                    "Your Opportunity\nStarts Now.",
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
                    "We believe every individual holds unique skills. Find the job that truly fits your abilities.",
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
