import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_application_final/services/auth.dart';
import 'package:chat_application_final/views/home.dart';
import 'package:chat_application_final/views/signin.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MyApp()
    );
  
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TFE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
