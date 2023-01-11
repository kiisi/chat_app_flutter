import 'package:chat_app/login_page.dart';
import 'package:chat_app/utils/brand_color.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/services/auth_services.dart';

void main() => runApp(
    Provider(child: ChatApp(), create: (BuildContext context) => AuthServices));

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: BrandColor.primaryColor,
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
