import 'dart:convert';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString("assets/mock_messages.json");
    final List<dynamic> decodedList = jsonDecode(response) as List;
    final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();

    setState(() {
      _messages = _chatMessages;
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hi $username'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthServices>().logoutUser();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  entity: _messages[index],
                  alignment: _messages[index].author.username ==
                          context.read<AuthServices>().getUsername()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                );
              },
            ),
          ),
          ChatInput(onSubmit: onMessageSent),
        ],
      ),
    );
  }
}
