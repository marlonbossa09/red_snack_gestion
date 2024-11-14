import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/grafica.dart';
import 'package:red_snack_gestion/app/widget/prueba.dart'; // Biblioteca para gráficos de barras  

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
            Prueba(texto: 'Hola esto es una prueba desde un Widget personaliado'),
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
          // Mostrar el diálogo para agregar venta
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAddSaleDialog(context);
            },
          );
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

  // Método para construir el diálogo de agregar venta
  Widget _buildAddSaleDialog(BuildContext context) {
    String? selectedProduct;
    final TextEditingController productCountController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Agregar Venta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Desplegable para seleccionar el producto
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Seleccione el producto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            value: selectedProduct, // Valor inicial
            items: <String>['Producto 1', 'Producto 2', 'Producto 3'] // Opciones de productos
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedProduct = newValue; // Guardar el producto seleccionado
            },
          ),
          const SizedBox(height: 10),
          // Campo para ingresar la cantidad de productos
          TextField(
            controller: productCountController,
            decoration: InputDecoration(
              labelText: 'Numero de productos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number, // Permitir solo números
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Lógica para agregar la venta
            if (selectedProduct != null && productCountController.text.isNotEmpty) {
              // Aquí puedes hacer la validación o enviar la información al backend
              Navigator.of(context).pop(); // Cerrar el diálogo
            } else {
              // Mostrar algún mensaje de error si falta seleccionar producto o ingresar cantidad
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, seleccione un producto y la cantidad')),
              );
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
