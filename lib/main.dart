import 'package:chat_room_app/services/auth/auth_gate.dart';
import 'package:chat_room_app/themes/light_mode_theme.dart';
import 'package:chat_room_app/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA84DlV2jrfLRsEd6_T3Qcxtpdl01sdHOY",
          appId: "1:970167419492:android:ca1ff36bff892f3c36d571",
          messagingSenderId: "970167419492",
          projectId: "chatroomapp-e535a"));

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  )); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
