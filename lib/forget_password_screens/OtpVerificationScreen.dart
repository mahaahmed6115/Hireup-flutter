import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hireup/forget_password_screens/newpass.dart' show Newpass;

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  final Color _primaryColor = const Color(0xff43B343);
  final Color _titleColor = const Color(0xFF1A1D3D);

  Widget _buildOtpField(int index) {
    return Container(
      width: 60, // تكبير العرض قليلاً للشياكة
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[100], // خلفية باهتة متناسقة مع باقي الحقول
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? _primaryColor
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(
        child: TextFormField(
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _titleColor,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.length == 1 && index < 4) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
            setState(() {}); // لتحديث لون الحدود عند التغيير
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String email = "meho6115@gmail.com";

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
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Check your email",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: "We sent a reset link to "),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                    const TextSpan(
                      text: "\nEnter the 5-digit code mentioned in the email",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // حقول الـ OTP بتوزيع متناسق
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) => _buildOtpField(index)),
              ),

              const SizedBox(height: 60),

              // زرار التفعيل المتناسق
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Newpass()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    shadowColor: _primaryColor.withOpacity(0.3),
                  ),
                  child: const Text(
                    "Verify Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // نص إعادة الإرسال
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Haven't got the email yet? ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Resend email",
                      style: TextStyle(
                        color: _primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
