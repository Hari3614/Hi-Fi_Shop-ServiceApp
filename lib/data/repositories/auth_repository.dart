import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project1/data/model/user.dart';

class AuthRepository {
  final String _loginUrl = 'https://reqres.in/api/login';

  Future<User?> login(String email, String password) async {
    final response = await http.post(Uri.parse(_loginUrl),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User(email: email, token: json['token']);
    } else {
      throw Exception('Login failed');
    }
  }
}
