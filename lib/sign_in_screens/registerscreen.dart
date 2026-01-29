import 'package:flutter/material.dart';
import 'package:hireup/sign_in_screens/login.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1D3D),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // صورة الأرت (Illustration) بمقاس متناسق
              Image.asset(
                "assets/images/Mobile login-bro.png",
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // حقول البيانات باستخدام ويدجت موحدة للشياكة
              _buildRegisterField(
                hint: "First Name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),
              _buildRegisterField(
                hint: "Last Name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),
              _buildRegisterField(
                hint: "Email Address",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 15),
              _buildRegisterField(
                hint: "Password",
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              _buildRegisterField(
                hint: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                isPassword: true,
              ),

              const SizedBox(height: 30),

              // زرار الـ Register العريض
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff43B343),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    shadowColor: Colors.green.withOpacity(0.3),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // جملة العودة للـ Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have Account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xff43B343),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة عشان الكود يكون Clean ومنظم
  Widget _buildRegisterField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xff43B343)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xff43B343), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
    );
  }
}
