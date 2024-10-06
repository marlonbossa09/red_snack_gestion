import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/components/appbar.dart';  
import 'package:red_snack_gestion/app/models/producto.dart';  
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';  
class InventarioScreen extends StatefulWidget {  
  const InventarioScreen({super.key});  

  @override  
  // ignore: library_private_types_in_public_api
  _InventarioScreenState createState() => _InventarioScreenState();  
}  

class _InventarioScreenState extends State<InventarioScreen> {  
  final InventarioController _controller = InventarioController();  

  @override  
  Widget build(BuildContext context) {  
    return CustomAppBar(  
      body: Stack(  
        children: [  
          Column(  
            children: [  
              Expanded(  
                child: ListView.builder(  
                  itemCount: _controller.productos.length,  
                  itemBuilder: (context, index) {  
                    final producto = _controller.productos[index];  
                    return FutureBuilder<bool>(  
                      future: _controller.esImagenMayorA500px(producto.fotoUrl),  
                      builder: (context, snapshot) {  
                        if (snapshot.connectionState == ConnectionState.waiting) {  
                          return const Center(child: CircularProgressIndicator());  
                        } else if (snapshot.hasError || snapshot.data == true) {  
                          return _crearItemProducto(  
                            producto,  
                            const Icon(Icons.flash_on, size: 50, color: Colors.yellow),  
                            index,  
                          );  
                        } else {  
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
              ),  
            ],  
          ),  
          Positioned(  
            bottom: 10,  
            right: 10,  
            child: FloatingActionButton(  
              onPressed: () {  
                mostrarDialogoAgregarProducto(context, (Producto nuevoProducto) {  
                  setState(() {  
                    _controller.agregarProducto(nuevoProducto);  
                  });  
                });  
              },  
              // ignore: sort_child_properties_last  
              child: const Icon(Icons.add),  
              backgroundColor: Colors.red,  
            ),  
          ),  
        ],  
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