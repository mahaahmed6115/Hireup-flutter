import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Set a new password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Create a new password. Ensure it differs from previous ones for security",
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),

              const SizedBox(height: 40),

              // حقل كلمة السر الأولى
              _buildLabel("Password"),
              const SizedBox(height: 10),
              _buildPasswordField(
                hint: "Create new password",
                isVisible: _isPasswordVisible,
                onToggle: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),

              const SizedBox(height: 25),

              // حقل تأكيد كلمة السر
              _buildLabel("Confirm Password"),
              const SizedBox(height: 10),
              _buildPasswordField(
                hint: "Re-type new password",
                isVisible: _isConfirmPasswordVisible,
                onToggle: () => setState(
                  () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                ),
              ),

              const SizedBox(height: 50),

              // زرار التحديث الشيك
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Succespas(),
                      ),
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
                    "Update Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // ويدجت مساعدة للعناوين الصغيرة
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _titleColor,
      ),
    );
  }

  // ويدجت مساعدة لبناء حقول الباسورد بشكل موحد
  Widget _buildPasswordField({
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.lock_outline, color: _primaryColor),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: isVisible ? _primaryColor : Colors.grey,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
    );
  }
}
