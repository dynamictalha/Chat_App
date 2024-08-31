import 'package:chat_room_app/Widgets/chat_bubble.dart';
import 'package:chat_room_app/Widgets/text_fields.dart';
import 'package:chat_room_app/services/auth/auth_services.dart';
import 'package:chat_room_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  final String receiveEmail;
  final String receiverID;
  ChatPage({
    super.key,
    required this.receiveEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth service
  final ChatServices _chatServices = ChatServices();

  final AuthServices _authServices = AuthServices();

// For textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listener to focus mode
    myFocusNode.addListener(() {
      // cause a delay so that the keyboard time to show up
      // the amount of remaining space will be calculated
      // the scroll down

      Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
    });

    // wait a build for listView to be build, the scroll to bottom 
     
      Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

// Scroll controller

  final _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }



  // sending a message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatServices.sendMessage(
          widget.receiverID, _messageController.text);

      // clear the controlller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.receiveEmail)),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // display all message
          Expanded(child: _buildMessageList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessage(widget.receiverID, senderID),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("ERROE");
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("LOADING...");
          }

          // return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // current user
    bool isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser()!.uid;

    // align message to right side for current and receiver left side
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data["message"],
              isCurrentUser: isCurrentUser,
            )
          ],
        ));
  }

  // Build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          // textfield take most of the space
          Expanded(
              child: MyTextField(
                  hintText: "Message",
                  obscureText: false,
                  controller: _messageController, focusNode: myFocusNode,
              //      textInputAction: TextInputAction.send, // Set the action to 'send'
              // onSubmitted: (value) => sendMessage(), // Call sendMessage() on Enter
                  )),

          // Send Button
          Container(
              decoration: BoxDecoration(
                color: Color(0xFF04D939),
                borderRadius: BorderRadius.circular(50),
              ),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
