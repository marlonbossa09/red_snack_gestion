// ignore_for_file: avoid_print

import 'package:flutter/material.dart';  
import 'package:red_snack_gestion/models/usuario.dart';
class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});
  
  @override  
  // ignore: library_private_types_in_public_api
  _RegistroUsuarioState createState() => _RegistroUsuarioState();  
}  

class _RegistroUsuarioState extends State<RegistroUsuario> {  
  final _nombreController = TextEditingController();  
  final _correoController = TextEditingController();  
  final _contrasenaController = TextEditingController();  

  void _registrarUsuario() {  
    String nombre = _nombreController.text;  
    String correo = _correoController.text;  
    String contrasena = _contrasenaController.text;  

    // Crea una nueva instancia de Usuario  
    Usuario nuevoUsuario = Usuario(  
      nombre: nombre,  
      correo: correo,  
      contrasena: contrasena,  
    );  

    // Aquí puedes añadir la lógica para guardar el nuevo usuario (por ejemplo, en un backend)  

    // Para fines de demostración, simplemente imprimimos los datos en la consola  
    print(nuevoUsuario.toJson());  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Registro de Usuario'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            TextField(  
              controller: _nombreController,  
              decoration: const InputDecoration(labelText: 'Nombre'),  
            ),  
            TextField(  
              controller: _correoController,  
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),  
              keyboardType: TextInputType.emailAddress,  
            ),  
            TextField(  
              controller: _contrasenaController,  
              decoration: const InputDecoration(labelText: 'Contraseña'),  
              obscureText: true,  
            ),  
            const SizedBox(height: 20),  
            ElevatedButton(  
              onPressed: _registrarUsuario,  
              child: const Text('Registrar'),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}