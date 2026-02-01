import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // 1. تعديل الـ baseUrl: شيلنا /api لأن المسار في الـ Swagger هو /Auth مباشرة
  static const String baseUrl = "http://10.0.2.2:8089";

  // 2. إرسال طلب نسيان كلمة السر
  Future<bool> sendForgetPasswordEmail(String email) async {
    final response = await http.post(
      // التعديل: التأكد من حرف الـ A الكابيتال في Auth كما في الـ Swagger
      Uri.parse("$baseUrl/Auth/forget-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    return response.statusCode == 200;
  }

  // 3. التحقق من الـ OTP (لو لسه محتاجاه كخطوة منفصلة)
  Future<bool> verifyOtp(String email, String code) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Auth/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "code": code}),
    );
    return response.statusCode == 200;
  }

  // 4. إضافة دالة الـ Reset Password النهائية (اللي بنستخدمها في صفحة Newpass)
  Future<bool> resetPassword(
      String email,
      String code,
      String newPassword,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Auth/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "code": code,
        "newPassword": newPassword,
      }),
    );
    return response.statusCode == 200;
  }
}