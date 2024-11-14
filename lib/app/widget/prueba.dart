import 'package:flutter/material.dart';

class Prueba extends StatelessWidget {
  String texto;
  Prueba({super.key, required this.texto});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('${this.texto}')
        ],
      ),
    );
  }
}