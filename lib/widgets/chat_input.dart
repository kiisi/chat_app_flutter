import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final chatMessageController = TextEditingController();

  void sendMessage() {
    print('Chat Message: ${chatMessageController.text}');
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
