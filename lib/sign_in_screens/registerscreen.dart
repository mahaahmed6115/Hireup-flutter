import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/sign_in_screens/login.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1D3D),
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Illustration
              Image.asset(
                "assets/images/Mobile login-bro.png",
                height: 0.25.sh,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20.h),

              _buildRegisterField(
                hint: "First Name",
                icon: Icons.person_outline,
              ),
              SizedBox(height: 15.h),

              _buildRegisterField(
                hint: "Last Name",
                icon: Icons.person_outline,
              ),
              SizedBox(height: 15.h),

              _buildRegisterField(
                hint: "Email Address",
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 15.h),

              _buildRegisterField(
                hint: "Password",
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              SizedBox(height: 15.h),

              _buildRegisterField(
                hint: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                isPassword: true,
              ),

              SizedBox(height: 30.h),

              /// Register Button
              SizedBox(
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff43B343),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 5,
                    shadowColor: Colors.green.withOpacity(0.3),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// Back to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Login(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: const Color(0xff43B343),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable TextField
  Widget _buildRegisterField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.sp),
        prefixIcon: Icon(
          icon,
          color: const Color(0xff43B343),
          size: 22.sp,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xff43B343),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.h,
          horizontal: 20.w,
        ),
      ),
    );
  }
}
