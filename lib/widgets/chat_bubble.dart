import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Alignment alignment;

  ChatBubble({required this.message, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            Image.network(
              'https://3009709.youcanlearnit.net/Alien_LIL_131338.png',
              height: 100,
            ),
          ],
        ),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
