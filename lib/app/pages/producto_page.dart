import 'package:flutter/material.dart';  
import 'package:red_snack_gestion/app/pages/chat_page.dart';  
import 'package:red_snack_gestion/app/widget/appbar.dart';  

class ProductoPage extends StatefulWidget {  
  const ProductoPage({super.key});  

  @override  
  State<ProductoPage> createState() => _ProductoPageState();  
}  

class _ProductoPageState extends State<ProductoPage> {  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: const GlobalAppBar(title: 'Producto', chatPage: Chats()),  
      drawer: const SideMenu(),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children: [  
            // Icono del producto  
            Container(  
              width: 100,  
              height: 100,  
              decoration: BoxDecoration(  
                border: Border.all(color: Colors.yellow, width: 2),  
                borderRadius: BorderRadius.circular(8),  
              ),  
              child: const Icon(  
                Icons.camera, // Cambia esto por el icono que desees  
                color: Colors.yellow,  
                size: 50,  
              ),  
            ),  
            const SizedBox(height: 20),  
            // Información del producto  
            const Text(  
              'Nombre: Deditos',  
              style: TextStyle(fontSize: 18),  
            ),  
            const SizedBox(height: 10),  
            const Text(  
              'Cantidad en inventario: 2000',  
              style: TextStyle(fontSize: 16),  
            ),  
            const SizedBox(height: 10),  
            const Text(  
              'Precio: 10000',  
              style: TextStyle(fontSize: 16),  
            ),  
            const SizedBox(height: 10),  
            const Text(  
              'Costo de fabricación: 1000',  
              style: TextStyle(fontSize: 16),  
            ),  
            const SizedBox(height: 20),  
            // Botón para agregar a inventario  
            ElevatedButton(  
              onPressed: () {  
                // Acción al presionar el botón  
              },  
              style: ElevatedButton.styleFrom(  
                // ignore: deprecated_member_use
                primary: Colors.red, // Color de fondo  
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),  
              ),  
              child: const Text(  
                'Agregar a inventario',  
                style: TextStyle(color: Colors.white),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}