import 'package:chat_room_app/pages/login_page.dart';
import 'package:chat_room_app/pages/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegistor extends StatefulWidget {
  const LoginOrRegistor({super.key});

  @override
  State<LoginOrRegistor> createState() => _LoginOrRegistorState();
}

class _LoginOrRegistorState extends State<LoginOrRegistor> {
  // initially, show login
  bool showLoginPage = true;

  // troggle b/w login and register page
  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Login_page(onTap: togglePage,);
    } else{
      return RegisterPage(onTap: togglePage,);
    }
  }
}