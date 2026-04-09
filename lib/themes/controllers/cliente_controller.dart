import 'dart:convert';
import 'package:http/http.dart' as http;

class ClienteController {
  final String baseUrl = 'https://backend-autos-2-birr.onrender.com';

  // 🔹 REGISTRO
  Future<http.Response> registerCliente(
      String nombre, String email, String password, String numLic) async {

    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'numLic': numLic,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Error al registrar cliente: ${response.body}');
    }
  }

  // 🔹 LOGIN
  Future<Map<String, dynamic>> loginCliente(
      String email, String password) async {

    final url = Uri.parse('$baseUrl/login'); // 🔥 IMPORTANTE

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'mensaje': responseData['mensaje'],
        'cliente': responseData['cliente'],
      };
    } else {
      return {
        'success': false,
        'mensaje': responseData['mensaje'] ?? 'Error en login',
      };
    }
  }
  
}