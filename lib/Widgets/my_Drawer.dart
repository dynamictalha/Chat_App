import 'package:chat_room_app/services/auth/auth_services.dart';
import 'package:chat_room_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() async{
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo 
            DrawerHeader(
              child: Center(
                child:  FaIcon(
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
              ),
            ),

          // home list title
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text("H O M E",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ),
              leading: FaIcon(FontAwesomeIcons.houseChimneyUser,
               size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: (){Navigator.pop(context);},
            ),
          ),
          // sitting list title
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text("S E T T I N G",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ),
              leading: FaIcon(FontAwesomeIcons.gear,
               size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: (){
                // pop drawer
                Navigator.pop(context);

                // go to settings
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
              },
            ),
          ),

          //logout list title
           Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text("L O G O U T",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ),
              leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket,
               size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}