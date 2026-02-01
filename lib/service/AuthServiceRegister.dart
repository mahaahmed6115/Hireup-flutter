import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ApiConstants.dart';


class AuthServiceRegister {
  // Function to register user
  static Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.register);

    final body = jsonEncode({
      "email": email,
      "password": password,
      "firstName": firstName ,
      "lastName": lastName,
    });

    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // التسجيل ناجح
        return true;
      } else {
        // فشل التسجيل
        print("Error: ${response.body}");
        return false;
      }
    } catch (e ,s) {
      print("Exception: $e");
      print("STACK TRACE: $s");
      return false;
    }
  }
}
