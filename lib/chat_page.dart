import 'dart:convert';
import 'package:chat_app/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/repo/image_repository.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];

  ImageRepository _imageRepo = ImageRepository();

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
      appBar: AppBar(
        title: Text('Hi $username'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
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
          FutureBuilder<List<PixelFordImage>>(
            future: _imageRepo.getNetworkImages(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PixelFordImage>> snapshot) {
              if (snapshot.hasData)
                return Image.network(snapshot.data![0].urlSmallSize);

              return CircularProgressIndicator();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  entity: _messages[index],
                  alignment: _messages[index].author.username == 'kiisi'
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
