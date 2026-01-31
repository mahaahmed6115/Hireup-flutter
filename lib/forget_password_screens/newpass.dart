import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireup/forget_password_screens/successpass.dart';

class Newpass extends StatefulWidget {
  const Newpass({super.key});

  @override
  State<Newpass> createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final Color _primaryColor = const Color(0xff43B343);
  final Color _titleColor = const Color(0xFF1A1D3D);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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

                /// Title
                Text(
                  "Set a new password",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: _titleColor,
                  ),
                ),

                SizedBox(height: 12.h),

                /// Description
                Text(
                  "Create a new password. Ensure it differs from previous ones for security",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 40.h),

                /// Password
                _buildLabel("Password"),
                SizedBox(height: 10.h),
                _buildPasswordField(
                  controller: _passwordController,
                  hint: "Create new password",
                  isVisible: _isPasswordVisible,
                  onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 25.h),

                /// Confirm Password
                _buildLabel("Confirm Password"),
                SizedBox(height: 10.h),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hint: "Re-type new password",
                  isVisible: _isConfirmPasswordVisible,
                  onToggle: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password cannot be empty";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 50.h),

                /// Update Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Succespas(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      elevation: 5,
                      shadowColor: _primaryColor.withOpacity(0.3),
                    ),
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
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

  /// Label Widget
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

  /// Password Field Widget
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
      style: TextStyle(fontSize: 16.sp),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: _primaryColor,
          size: 22.sp,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: isVisible ? _primaryColor : Colors.grey,
            size: 22.sp,
          ),
          onPressed: onToggle,
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
            color: _primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
