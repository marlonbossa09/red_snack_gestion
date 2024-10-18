import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatState();
}

class _ChatState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  GlobalAppBar(title: 'Chats', chatPage: Chats()),   
      drawer: SideMenu(),
    );
  }
}