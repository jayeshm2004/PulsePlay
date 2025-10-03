import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Map<String,dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    if(response.statusCode!=201){
      //handle the error
    }

    final user=json.decode(response.body) as Map<String,dynamic>;
  }

  Future<Map<String,dynamic>> login({
    required String email,
    required String password
}) async {
    final response=await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/login'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'email':email,
        'password':password
      })
    );

    if(response.statusCode!=201){
      //handle the error
    }

    json.decode(response.body);
  }
}
