import 'package:flutter/material.dart';
import 'package:chat_app/models/chat_message_entity.dart';

class ChatInput extends StatelessWidget {
  final chatMessageController = TextEditingController();
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({required this.onSubmit});

  void sendMessage() {
    final newChatMessage = ChatMessageEntity(
        text: '${chatMessageController.text}',
        id: "233",
        createdAt: DateTime.now().microsecondsSinceEpoch,
        author: Author(username: "kiisi"));

    onSubmit(newChatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.add, color: Colors.white),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 5,
              minLines: 1,
              controller: chatMessageController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type your message',
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
    );
  }
}
