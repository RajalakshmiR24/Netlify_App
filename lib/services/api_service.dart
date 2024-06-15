import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nestify_app/models/user.dart';

class ApiService {
  static const String apiUrl = 'https://raw.githubusercontent.com/RRajalakshmi24/curd.json/main/curd.json';

  static Future<void> createUser(User user) async {
    final response = await http.post(Uri.parse(apiUrl + '/users'), body: {
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
      'address': user.address,
    });

    if (response.statusCode == 201) {
      print('User created successfully');
    } else {
      throw Exception('Failed to create user');
    }
  }
}
