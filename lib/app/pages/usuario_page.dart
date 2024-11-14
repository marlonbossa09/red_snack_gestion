import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  bool _showPasswordFields = false; // Estado para mostrar/ocultar campos de contraseña
  bool _showEmailFields = false; // Estado para mostrar/ocultar campos de actualización de correo

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Controlador para el correo electrónico
  final TextEditingController _newEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Usuario', chatPage: Chats()),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen de perfil y nombre
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.purple[100],
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'NOMBRE',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Información del usuario
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ID'),
                    const Divider(),
                    const Text('ID Emprendimiento'),
                    const Divider(),
                    const Text('Correo electrónico'),
                    const Divider(),
                    // Botón para cambiar la contraseña
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cambiar contraseña'),
                        IconButton(
                          icon: Icon(
                            _showPasswordFields
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPasswordFields = !_showPasswordFields; // Mostrar/ocultar campos de contraseña
                            });
                          },
                        ),
                      ],
                    ),
                    // Campos para cambiar la contraseña
                    Visibility(
                      visible: _showPasswordFields,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          TextField(
                            controller: _oldPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Antigua contraseña',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Nueva contraseña',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirmar nueva contraseña',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Aquí puedes validar y cambiar la contraseña
                              // Acciones para cambiar contraseña
                            },
                            child: const Text('Guardar contraseña'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Text('Correo electrónico'),
                    const Divider(),
                    // Botón para actualizar el correo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Actualizar correo'),
                        IconButton(
                          icon: Icon(
                            _showEmailFields
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                          onPressed: () {
                            setState(() {
                              _showEmailFields = !_showEmailFields; // Mostrar/ocultar campos de actualización de correo
                            });
                          },
                        ),
                      ],
                    ),
                    // Campos para actualizar el correo
                    Visibility(
                      visible: _showEmailFields,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          TextField(
                            controller: _newEmailController,
                            decoration: const InputDecoration(
                              labelText: 'Nuevo correo electrónico',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Aquí puedes validar y actualizar el correo
                              // Acciones para actualizar correo
                            },
                            child: const Text('Guardar correo'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Botón de borrar cuenta
              ElevatedButton(
                onPressed: () {
                  // Acción para borrar la cuenta
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Borrar cuenta',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
