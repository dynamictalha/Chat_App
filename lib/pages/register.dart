import 'package:chat_room_app/Widgets/button.dart';
import 'package:chat_room_app/Widgets/text_fields.dart';
import 'package:chat_room_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
    // tap to go to Register
final void Function()? onTap;
  
  RegisterPage({super.key,
  required this.onTap,
  });

   TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmpasswordController = TextEditingController();

  // register method
  void register(BuildContext context) async{
    // auth service 
    final authService = AuthServices();

    // password matches ---> confirmed password 
    if(_passwordController.text == _confirmpasswordController.text){
      // try login
    try{
      await authService.signUpWithEmailPassword(_emailController.text, _passwordController.text);
    } 
     catch(e){
      showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
        
      ),
      );
    }
  }
  // password matches ---> not confirmed password 
  else{
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Password doesn't matches"),
        
      ),
      );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            //logo
            FaIcon(
              FontAwesomeIcons.comments,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
              shadows: const [
                BoxShadow(
                  color: Colors.white, 
                  blurRadius: 6, 
                  spreadRadius: 2, 
                  offset: Offset(0, 4), 
                ),
                BoxShadow(
                  color: Colors.white, 
                  blurRadius: 6, 
                  spreadRadius: 2, 
                  offset: Offset(0, -4), 
                ),
              ],
            ),
            SizedBox(height: 20,),
            //welcome message
          Text("Let's create a account for you ;)",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 12,
          ),),
          SizedBox(height: 30,),
            // email textfield
          MyTextField (hintText: 'Enter Email', obscureText: false, controller: _emailController, focusNode: null,),
          SizedBox(height: 10,),
            // password textfield
           MyTextField (hintText: 'Enter Password', obscureText: true, controller: _passwordController, focusNode: null,),
           SizedBox(height: 10,),
           // confirm password
          MyTextField (hintText: 'Confirm Password', obscureText: true, controller: _confirmpasswordController, focusNode: null,),
           SizedBox(height: 20,), 
            // login button
          MyBotton(
            text: "Register", 
            onTap: () {  
              register(context);
            },
            ),
            SizedBox(height: 20,),
            // registor now or sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}