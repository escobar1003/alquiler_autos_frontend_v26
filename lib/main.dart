import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos_frontend_v26/views/loginScreen.dart';
import 'package:flutter_alquiler_autos_frontend_v26/views/registerScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LoginScreen()),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const Register(),
      },

    );
  }
}
