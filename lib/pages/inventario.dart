import 'package:flutter/material.dart';
import 'package:red_snack_gestion/models/producto.dart';
import 'package:red_snack_gestion/controller/inventario_controller.dart'; // Asegúrate de importar la clase

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  _InventarioScreenState createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final InventarioController _controller = InventarioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Productos'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: _controller.productos.length,
        itemBuilder: (context, index) {
          final producto = _controller.productos[index];
          return FutureBuilder<bool>(
            future: _controller.esImagenMayorA500px(producto.fotoUrl),
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
          mostrarDialogoAgregarProducto(context, _controller.agregarProducto);
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
            setState(() {
              _controller.eliminarProducto(index);
            });
          },
        ),
      ),
    );
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