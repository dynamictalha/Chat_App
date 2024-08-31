import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final isCurrentUser;
  const ChatBubble({super.key,
  required this.message,
  required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Color(0xFF04D939) : Color(0xFF027333) ,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
      child: Text(message,
      style: TextStyle(color: Colors.white),
      ),
    );
  }
}