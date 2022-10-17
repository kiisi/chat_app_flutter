import 'package:chat_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/chat_page.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
        ),
      ),
      home: LoginPage(),
      routes: {
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
