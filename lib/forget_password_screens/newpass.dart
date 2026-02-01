import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/forget_password_screens/successpass.dart';
// 1. التأكد من استيراد المكتبات اللازمة للربط
import 'package:http/http.dart' as http;
import 'dart:convert';

class Newpass extends StatefulWidget {
  // 2. استقبال الإيميل والكود (OTP) الممررين من صفحة الـ OTP
  final String email;
  final String code;

  const Newpass({super.key, required this.email, required this.code});

  @override
  State<Newpass> createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false; // حالة التحميل للزرار

  final Color _primaryColor = const Color(0xff43B343);
  final Color _titleColor = const Color(0xFF1A1D3D);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  // 3. دالة ربط الباك-إند لتحديث الباسورد (Reset Password)
  Future<void> _updatePassword() async {
    // التأكد من صحة المدخلات في الفورم (Validation)
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // بناءً على ملف docker-compose.yml، البورت هو 8089
      // وبناءً على AuthController.cs، المسار هو /auth/reset-password
      final url = Uri.parse("http://10.0.2.2:8089/Auth/reset-password");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        // ملي البيانات في الـ JSON بنفس الأسماء اللي مستنيها الـ ResetPasswordRequest في الباك-إند
        body: jsonEncode({
          "email": widget.email,
          "code": widget.code,
          "newPassword": _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // لو الحالة 200 (نجاح)، بننقل المستخدم لصفحة النجاح النهائية
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Succespas()),
        );
      } else {
        // عرض الخطأ الراجع من السيرفر (مثلاً لو الكود منتهي الصلاحية)
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${response.body}")));
      }
    } catch (e) {
      // في حالة وجود مشكلة في الاتصال بالسيرفر
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to connect to server. Check your connection."),
        ),
      );
    } finally {
      // إيقاف علامة التحميل في كل الأحوال
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Set a new password",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: _titleColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Create a new password for ${widget.email}",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 40.h),

                _buildLabel("Password"),
                SizedBox(height: 10.h),
                _buildPasswordField(
                  controller: _passwordController,
                  hint: "Create new password",
                  isVisible: _isPasswordVisible,
                  onToggle: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password cannot be empty";
                    // التأكد من طول الباسورد كما هو مطلوب في الباك-إند
                    if (value.length < 8)
                      return "Password must be at least 8 characters";
                    return null;
                  },
                ),

                SizedBox(height: 25.h),

                _buildLabel("Confirm Password"),
                SizedBox(height: 10.h),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hint: "Re-type new password",
                  isVisible: _isConfirmPasswordVisible,
                  onToggle: () => setState(
                        () =>
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                  ),
                  validator: (value) {
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                SizedBox(height: 50.h),

                /// Update Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _updatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "Update Password",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: _titleColor,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      validator: validator,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        prefixIcon: Icon(Icons.lock_outline, color: _primaryColor, size: 22.sp),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: isVisible ? _primaryColor : Colors.grey,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
        ),
      ),
    );
  }
}