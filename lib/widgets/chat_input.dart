import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/picker_body.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();

  String _selectedImageUrl = '';
  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  void sendMessage() async {
    String? usernameFromCache =
        await context.read<AuthServices>().getUsername();

    final newChatMessage = ChatMessageEntity(
        text: '${chatMessageController.text}',
        id: "233",
        createdAt: DateTime.now().microsecondsSinceEpoch,
        author: Author(username: usernameFromCache!));

    if (_selectedImageUrl.isNotEmpty) {
      newChatMessage.imageUrl = _selectedImageUrl;
    }

    widget.onSubmit(newChatMessage);
    chatMessageController.clear();
    _selectedImageUrl = '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return NetworkImagePickerBody(
                        onImageSelected: onImagePicked);
                  });
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                if (_selectedImageUrl.isNotEmpty)
                  Image.network(_selectedImageUrl, height: 50.0),
              ],
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
