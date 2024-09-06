import 'package:flutter/material.dart';
import 'package:red_snack_gestion/models/producto.dart';
import 'package:http/http.dart' as http;
//import 'dart:io';

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
      fotoUrl: 'https://via.placeholder.com/150',
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

  // Función para verificar el tamaño de la imagen
  Future<bool> _esImagenMayorA500px(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        int? width = int.tryParse(response.headers['content-width'] ?? '0');
        int? height = int.tryParse(response.headers['content-height'] ?? '0');
        if (width != null && height != null && (width > 500 || height > 500)) {
          return true;
        }
      }
    } catch (e) {
      return true; // Si hay un error, se asume que no se puede mostrar la imagen
    }
    return false;
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
          return FutureBuilder<bool>(
            future: _esImagenMayorA500px(producto.fotoUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == true) {
                // Si la imagen es mayor a 500px o si hay un error, se muestra el icono de rayo
                return _crearItemProducto(
                  producto,
                  const Icon(Icons.flash_on, size: 50, color: Colors.yellow),
                  index,
                );
              } else {
                // Si la imagen es válida, se muestra
                return _crearItemProducto(
                  producto,
                  Image.network(
                    producto.fotoUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  index,
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mostrarDialogoAgregarProducto(context, _agregarProducto);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Método para crear el ListTile del producto
  Widget _crearItemProducto(Producto producto, Widget leadingWidget, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: leadingWidget,
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
  }

  // Esta función simplemente agrega un producto a la lista
  void _agregarProducto(Producto producto) {
    setState(() {
      productos.add(producto);
    });
  }
}

// Método aparte que muestra el diálogo para agregar producto
void mostrarDialogoAgregarProducto(BuildContext context, Function(Producto) agregarProducto) {
  String nombre = '';
  String fotoUrl = '';
  double costoFabricacion = 0.0;
  double precioVenta = 0.0;
  int cantidad = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Agregar Nuevo Producto'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'URL de la Foto'),
                onChanged: (value) {
                  fotoUrl = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Costo de Fabricación'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  costoFabricacion = double.tryParse(value) ?? 0.0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Precio de Venta'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  precioVenta = double.tryParse(value) ?? 0.0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cantidad = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nombre.isNotEmpty && fotoUrl.isNotEmpty) {
                Producto nuevoProducto = Producto(
                  nombre: nombre,
                  fotoUrl: fotoUrl,
                  costoFabricacion: costoFabricacion,
                  precioVenta: precioVenta,
                  cantidad: cantidad,
                );
                agregarProducto(nuevoProducto);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      );
    },
  );
}
