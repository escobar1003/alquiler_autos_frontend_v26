import 'package:flutter/material.dart';
import 'package:flutter_alquiler_autos_frontend_v26/themes/controllers/cliente_controller.dart';
import 'package:flutter_alquiler_autos_frontend_v26/views/loginScreen.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  // Colores coherentes con LoginScreen
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
  final ClienteController clienteService =
      ClienteController(); //Instancia de la clase controlador ClienteService
  void registrarCliente() async {
    final nombre = _nombresController.text;
    final correo = _correoController.text;
    final numLic = _licenciaController.text;
    final password = _passwordController.text;
    final validarpassword = _validarPasswordController.text;

    if (password != validarpassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }try {
      final response = await clienteService.registerCliente(nombre, correo, numLic, password);
      print('Status code: ${response.statusCode}'); //ver por consola lo que estoy enviando
      print('Body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registro de usuario Exitoso!')),
      );
      }else{
        ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Existe un error de registro: ${response.body}')),
      );
      }
    } catch (e) {
      print('Error en el registro de usuario: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error en la conexion con el servidor')),
      );
    }
  }
  void limpiarCampos() {
    setState(() {
      _nombresController.clear();
      _correoController.clear();
      _licenciaController.clear();
      _passwordController.clear();
      _validarPasswordController.clear();
    });
  }
  void iraLogin() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
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
            shrinkWrap: true,
            children: [
              // Icono en la parte superior
              Icon(Icons.person_add, size: 80, color: encabezado),
              const SizedBox(height: 16.0),

              // Texto "Empecemos"
              Text(
                "Empecemos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: encabezado,
                ),
              ),
              const SizedBox(height: 8.0),

              // Texto "Crear una nueva cuenta"
              Text(
                "Crear una nueva cuenta",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: texto.withOpacity(0.7)),
              ),
              const SizedBox(height: 32.0),

              // Campo de nombre completo
              TextFormField(
                controller: _nombresController,
                style: TextStyle(color: texto),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: campos,
                  labelText: 'Nombre completo',
                  labelStyle: TextStyle(color: texto),
                  prefixIcon: Icon(Icons.person, color: encabezado),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de correo electrónico
              TextFormField(
                controller: _correoController,
                validator: (value) => value!.isEmpty ? "Digite su Email" : null,
                style: TextStyle(color: texto),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: campos,
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: texto),
                  prefixIcon: Icon(Icons.email, color: encabezado),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo de correo electrónico
              TextField(
                controller: _licenciaController,
                style: TextStyle(color: texto),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: campos,
                  labelText: 'Numero de licencia',
                  labelStyle: TextStyle(color: texto),
                  prefixIcon: Icon(
                    Icons.accessibility_sharp,
                    color: encabezado,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: texto),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: campos,
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: texto),
                  prefixIcon: Icon(Icons.lock, color: encabezado),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de confirmación de contraseña
              TextField(
                controller: _validarPasswordController,
                obscureText: true,
                style: TextStyle(color: texto),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: campos,
                  labelText: 'Confirmar contraseña',
                  labelStyle: TextStyle(color: texto),
                  prefixIcon: Icon(Icons.lock, color: encabezado),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Botón de registro
              ElevatedButton(
                onPressed: () {
                  registrarCliente();
                  limpiarCampos();
                  iraLogin();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: boton,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16.0),

              // Texto para iniciar sesión
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Ya tienes una cuenta? ",
                    style: TextStyle(color: texto),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        color: encabezado,
                        fontWeight: FontWeight.bold,
                      ),
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
}
