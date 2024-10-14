//import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:http/http.dart' as http;



class InventarioController {
  List<Producto> productos = [
    Producto(
      nombre: 'Chips Papas',
      costoFabricacion: 0.50,
      precioVenta: 1.00,
      cantidad: 100,
    ),
    Producto(
      nombre: 'Refresco Cola',
      costoFabricacion: 0.30,
      precioVenta: 1.20,
      cantidad: 50,
    ),
    Producto(
      nombre: 'Chocolate Bar',
      costoFabricacion: 0.80,
      precioVenta: 1.50,
      cantidad: 75,
    ),
  ];

  // Función para eliminar un producto de la lista
  void eliminarProducto(int index) {
    productos.removeAt(index);
  }

  // Función para agregar un producto a la lista
  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  // Función para verificar el tamaño de la imagen
  Future<bool> esImagenMayorA500px(String url) async {
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
}
