import 'package:flutter/material.dart';
import 'package:hireup/forget_password_screens/OtpVerificationScreen.dart';

class Forgetpass extends StatelessWidget {
  const Forgetpass({super.key});

  final Color primaryColor = const Color(0xff43B343);
  final double defaultPadding = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 24,
          ), // سهم أنحف وأشيك
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // عنوان الصفحة بخط عريض وجذاب
              const Text(
                "Forget Password",
                style: TextStyle(
                  color: Color(0xFF1A1D3D),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 12),
              // نص توضيحي
              Text(
                "Please enter your email to reset the password",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 50),

              // عنوان حقل الإدخال
              const Text(
                "Your Email Address",
                style: TextStyle(
                  color: Color(0xFF1A1D3D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              // حقل الإيميل بتصميم عصري (متناسق مع اللوج إن)
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "example@email.com",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // زرار إعادة تعيين كلمة السر
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpVerificationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    shadowColor: primaryColor.withOpacity(0.3),
                  ),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
