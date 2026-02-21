import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {

  static Future<Map<String, dynamic>> login({
    required String userName,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': userName,
        'password': password,
      }),
    );

    print("body :- ${response.body}");
    print("statusCode :- ${response.statusCode}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  static Future<Map<String, dynamic>> fetchProfile(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Unauthorized');
    }
  }
}