import 'package:flutter/material.dart';
import 'package:red_snack_gestion/models/producto.dart';


class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InventarioScreenState createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  // Ejemplo de lista de productos
  List<Producto> productos = [
    Producto(
      nombre: 'Chips Papas',
      fotoUrl: 'https://via.placeholder.com/150', // URL de ejemplo para la imagen
      costoFabricacion: 0.50,
      precioVenta: 1.00,
      cantidad: 100,
    ),
    Producto(
      nombre: 'Refresco Cola',
      fotoUrl: 'https://via.placeholder.com/150',
      costoFabricacion: 0.30,
      precioVenta: 1.20,
      cantidad: 50,
    ),
    Producto(
      nombre: 'Chocolate Bar',
      fotoUrl: 'https://via.placeholder.com/150',
      costoFabricacion: 0.80,
      precioVenta: 1.50,
      cantidad: 75,
    ),
  ];

  // Función para eliminar un producto de la lista
  void _eliminarProducto(int index) {
    setState(() {
      productos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Productos'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.network(
                producto.fotoUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(producto.nombre),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Costo de Fabricación: \$${producto.costoFabricacion.toStringAsFixed(2)}'),
                  Text('Precio de Venta: \$${producto.precioVenta.toStringAsFixed(2)}'),
                  Text('Cantidad en Inventario: ${producto.cantidad}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _eliminarProducto(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
