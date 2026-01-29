import 'package:flutter/material.dart';
import 'package:hireup/Homepage.dart';
import 'package:hireup/jop_details/track.dart';

class SuccessScreen extends StatelessWidget {
  final String companyName;
  final String jobRole;

  const SuccessScreen({
    super.key,
    required this.companyName,
    required this.jobRole,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF5E8D5E);
    const Color darkBlue = Color(0xFF1A1D3D);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // الصورة المطلوبة بالمسار اللي حددتيه
              Image.asset(
                'assets/images/Done.png',
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              const Text(
                'Successful',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'You\'ve successfully applied to $companyName\n$jobRole role.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),

              // زرار التتبع - بيفتح شاشة التتبع
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackingScreen(
                          job: {
                            'role': jobRole,
                            'company': companyName,
                            'salary': '\$180,000/year',
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Track',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // زرار العودة للوظائف - بيرجع للهوم بيج مباشرة
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Browse Jobs',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
