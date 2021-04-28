import 'package:flutter/material.dart';
import 'package:chat_application_final/services/auth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TFE"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthMethods().signInWithGoogle(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.blueAccent,
              //gradient: ,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Se connecter avec Google",
               style: TextStyle(fontSize: 16, color: Colors.white),
              /*style: GoogleFonts.mcLaren(
                  fontSize: 16, color: Colors.white
              )*/
            ),
          ),
        ),
      ),
    );
  }
}
