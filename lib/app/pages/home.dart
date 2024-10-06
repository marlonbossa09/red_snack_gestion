import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/components/appbar.dart';  
// Asegúrate de que la ruta sea correcta  

class HomeScreen extends StatelessWidget {  
  const HomeScreen({Key? key}) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return const Scaffold(  
      appBar: PreferredSize(  
        preferredSize: Size.fromHeight(56.0), // Ajusta la altura según sea necesario  
        child: CustomAppBar(), // Aquí llamas al componente  
      ),  
      body: Center(  
        child: Text(  
          '¡Bienvenido a Red Snack!',  
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),  
        ),  
      ),  
    );  
  }  
}