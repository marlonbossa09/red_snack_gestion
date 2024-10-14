import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';

class HistorialVentas extends StatefulWidget {
  const HistorialVentas({super.key});

  @override
  State<HistorialVentas> createState() => _HistorialVentasState();
}

class _HistorialVentasState extends State<HistorialVentas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  GlobalAppBar(title: 'Home', chatPage: Chats()),   
      drawer: SideMenu(),
    );
  }
}