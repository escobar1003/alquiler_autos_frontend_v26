import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos_frontend_v26/themes/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos_frontend_v26/views/loginScreen.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Colores
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _licenciaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _validarPasswordController =
      TextEditingController();

 final ClienteController clienteController = ClienteController();
  void registrarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    final String nombre = _nombresController.text.trim();
    final String email = _correoController.text.trim();
    final String password = _passwordController.text.trim();
    final String numLic = _licenciaController.text.trim();

    if (password != _validarPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    try {
      final response = await clienteController.registerCliente(
        nombre,
        email,
        password,
        numLic,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro exitoso")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Error al registrar cliente: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _correoController.dispose();
    _licenciaController.dispose();
    _passwordController.dispose();
    _validarPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Icon(Icons.person_add, size: 80, color: encabezado),
              const SizedBox(height: 16),

              Text(
                "Empecemos",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: encabezado),
              ),

              const SizedBox(height: 8),

              Text(
                "Crear una nueva cuenta",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: texto.withOpacity(0.7)),
              ),

              const SizedBox(height: 32),

              /// NOMBRE
              TextFormField(
                controller: _nombresController,
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su nombre" : null,
                decoration: _inputDecoration("Nombre completo", Icons.person),
              ),

              const SizedBox(height: 16),

              /// EMAIL
              TextFormField(
                controller: _correoController,
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su email" : null,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration("Correo electrónico", Icons.email),
              ),

              const SizedBox(height: 16),

              /// LICENCIA
              TextFormField(
                controller: _licenciaController,
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su licencia" : null,
                decoration: _inputDecoration(
                    "Número de licencia", Icons.badge),
              ),

              const SizedBox(height: 16),

              /// PASSWORD
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Mínimo 6 caracteres" : null,
                decoration: _inputDecoration("Contraseña", Icons.lock),
              ),

              const SizedBox(height: 16),

              /// CONFIRMAR PASSWORD
              TextFormField(
                controller: _validarPasswordController,
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Confirme su contraseña" : null,
                decoration:
                    _inputDecoration("Confirmar contraseña", Icons.lock),
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: registrarCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: boton,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿Ya tienes una cuenta?",
                      style: TextStyle(color: texto)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(
                          color: encabezado,
                          fontWeight: FontWeight.bold),
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

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: campos,
      labelText: label,
      prefixIcon: Icon(icon, color: encabezado),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}