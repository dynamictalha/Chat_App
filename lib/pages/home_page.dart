import 'package:chat_room_app/Widgets/my_Drawer.dart';
import 'package:chat_room_app/Widgets/user_title.dart';
import 'package:chat_room_app/pages/chat_page.dart';
import 'package:chat_room_app/services/auth/auth_services.dart';
import 'package:chat_room_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

// chat and auth service

final ChatServices _chatServices = ChatServices();
final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Chat")),
        backgroundColor:Colors.transparent ,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: _builderUserList(),
    );
  }

  // Build a list of users expected for the current logged in user
  Widget _builderUserList(){
    return StreamBuilder(
      stream: _chatServices.getUserStream(), 
      builder: (context,snapshot){
        // error
        if(snapshot.hasError){
          return const Text("Error");
        }
        // loading..
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading");
        }

        // return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData)=> _builderUserListItem(userData,context)).toList(),
        );
      }
      );
  }

  // build individual list title for user
  Widget _builderUserListItem(Map<String,dynamic> userData,BuildContext context){
    // Display all user except for current user
   if(userData["email"] != _authServices.getCurrentUser()!.email){
     return UserTitle(
      text: userData["email"],
      onTap: (){
        // tagged on a user -- > go to chat
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
          receiveEmail: userData["email"],
          receiverID: userData['uid'],
        )));
      },
    ); 
   } else{
    return Container();
   }
  }

}