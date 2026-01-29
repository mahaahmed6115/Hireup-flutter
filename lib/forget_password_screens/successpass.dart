import 'package:flutter/material.dart';
import 'package:hireup/sign_in_screens/login.dart';

class Succespas extends StatelessWidget {
  const Succespas({super.key});

  final Color _primaryColor = const Color(0xff43B343);
  final Color _titleColor = const Color(0xFF1A1D3D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة تعبيرية عن النجاح (Illustration)
                // لو عندك صورة جاهزة استخدمي Image.asset، لو معندكيش الدايرة دي شكلها مودرن جداً
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 65,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Text(
                  "Successful",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: _titleColor,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Congratulations! Your password has been changed. Click continue to login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 50),

                // زرار الاستمرار بتصميم متناسق مع باقي الشاشات
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      shadowColor: _primaryColor.withOpacity(0.3),
                    ),
                    child: const Text(
                      "Continue to Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
