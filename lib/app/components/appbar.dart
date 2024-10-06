import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/inventario.dart';  

class CustomAppBar extends StatelessWidget {  
  final Widget body;  

  const CustomAppBar({Key? key, required this.body}) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Home Red Snack'),  
        backgroundColor: Colors.red,  
        actions: [  
          IconButton(  
            icon: const Icon(Icons.notifications),  
            onPressed: () {  
              // Lógica para notificaciones  
            },  
          ),  
        ],  
      ),  
      drawer: Drawer(  
        child: ListView(  
          padding: EdgeInsets.zero,  
          children: <Widget>[  
            const DrawerHeader(  
              decoration: BoxDecoration(  
                color: Colors.red,  
              ),  
              child: Text(  
                'Menú',  
                style: TextStyle(  
                  color: Colors.white,  
                  fontSize: 24,  
                ),  
              ),  
            ),  
            ListTile(  
              leading: const Icon(Icons.dashboard),  
              title: const Text('Dashboard'),  
              onTap: () {  
                // Lógica para ir al Dashboard  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.inventory),  
              title: const Text('Inventario'),  
              onTap: () {  
                // Lógica para ir al Inventario  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => const InventarioScreen()),  
                );  
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.settings),  
              title: const Text('Configuraciones'),  
              onTap: () {  
                // Lógica para ir a Configuraciones  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.exit_to_app),  
              title: const Text('Cerrar Sesión'),  
              onTap: () {  
                // Lógica para cerrar sesión  
                Navigator.pop(context);  
              },  
            ),  
          ],  
        ),  
      ),  
      body: body, // usaremos el cuerpo que se pasa como parámetro  
    );  
  }  
}