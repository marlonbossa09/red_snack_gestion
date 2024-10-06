
import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/inicio_sesion.dart';

class RedSnackApp extends StatelessWidget {
  const RedSnackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Snack gestion',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginScreen(),
    );
  }
}