import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;

  const MessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(message.senderImage),
      ),
      title: Text(message.senderName),
      subtitle: Text(message.content),
      trailing: Text(message.timestamp.toString()),
    );
  }
}
