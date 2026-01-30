import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/forget_password_screens/OtpVerificationScreen.dart';

class Forgetpass extends StatelessWidget {
  const Forgetpass({super.key});

  final Color primaryColor = const Color(0xff43B343);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Title
              Text(
                "Forget Password",
                style: TextStyle(
                  color: const Color(0xFF1A1D3D),
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                ),
              ),

              SizedBox(height: 12.h),

              /// Description
              Text(
                "Please enter your email to reset the password",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 50.h),

              /// Label
              Text(
                "Your Email Address",
                style: TextStyle(
                  color: const Color(0xFF1A1D3D),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 12.h),

              /// Email Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: "example@email.com",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: primaryColor,
                    size: 22.sp,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 20.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 60.h),

              /// Reset Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OtpVerificationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 5,
                    shadowColor: primaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
