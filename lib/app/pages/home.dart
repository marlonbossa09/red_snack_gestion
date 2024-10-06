import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/components/appbar.dart';  


class HomeScreen extends StatelessWidget {  
  const HomeScreen({Key? key}) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return const CustomAppBar(  
      body: Center(  
        child: Text(  
          '¡Bienvenido a Red Snack!',  
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),  
        ),  
      ),  
    );  
  }  
}