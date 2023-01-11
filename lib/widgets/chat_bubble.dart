import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;

  ChatBubble({required this.alignment, required this.entity});

  /* width: MediaQuery.of(context).size.width * 0.5, */

  @override
  Widget build(BuildContext context) {
    bool isAuthor =
        entity.author.username == context.read<AuthServices>().getUsername();
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            if (entity.imageUrl != null)
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(entity.imageUrl!),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
          ],
        ),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isAuthor ? Theme.of(context).primaryColor : Colors.black87,
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
