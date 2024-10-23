import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/grafica.dart'; // Biblioteca para gráficos de barras

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Inicio', chatPage: Chats()),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Usa Expanded o Flexible para el gráfico
            const Expanded(
              child: TransaccionesEstado(),
            ),
            const SizedBox(height: 5),
            // Tarjetas con ventas, gastos, ganancias
            _buildInfoCard('Ventas:'),
            const SizedBox(height: 10),
            _buildInfoCard('Gastos: '),
            const SizedBox(height: 10),
            _buildInfoCard('Ganancias: '),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddVentaDialog(context); // Llamada a la función para mostrar el diálogo
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Método para construir las tarjetas de información
  Widget _buildInfoCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Función que muestra el diálogo de agregar venta
  void _showAddVentaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Agregar Venta',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo para seleccionar el producto
              TextField(
                decoration: InputDecoration(
                  labelText: 'Seleccione el producto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Campo para ingresar el número de productos
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número de productos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Acción para agregar la venta
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                ),
                child: const Text(
                  'Agregar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
