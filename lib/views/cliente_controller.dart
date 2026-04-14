import 'dart:convert'; // Trabajar en formato JSON
import 'package:http/http.dart' as http; //Realizar las solicitudes HTTP

//definimos una clase Cliente

class ClienteService {
  final String baseUrl =
      'https://bakendalquilerautos.onrender.com/api/clientes';

  //Registrar cliente
  Future<http.Response> registrarCliente(
    String nombre,
    String correo,
    String numLic,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'numLic': numLic,
        'password': password,
      }),
    );
    return response; //Future devuelve un objeto response al terminar
  } //uri.parse construye la url completa para la solicitud del POST

  //http.post metod para enviar datos al servidor
  //headers el encabezado del mensaje body es el objeto Dart(mapa de datos) JsonEncode

  //Login cambiar
   Future<Map<String, dynamic>> loginCliente(String correo, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo, 'password': password}),
    );
  final responseData = jsonDecode(response.body);
  print("Cuerpo del mensaje: ,${response.body}");
  if (response.statusCode == 200) {
    return {
      'success': true,
      'mensaje': responseData['mensaje'],
      'cliente': responseData['cliente']
    };
    
  }else{
    return{
      'success': false,
      'mensaje': responseData['mensaje'] ?? 'Credenciales son incorrectas'
    };
  }
  }
}