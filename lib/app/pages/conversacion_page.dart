import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';

class ConversacionPage extends StatefulWidget {
  const ConversacionPage({super.key});

  @override
  State<ConversacionPage> createState() => _ConversacionPageState();
}

class _ConversacionPageState extends State<ConversacionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  GlobalAppBar(title: 'Home', chatPage: Chats()),   
      drawer: SideMenu(),
    );
  }
}