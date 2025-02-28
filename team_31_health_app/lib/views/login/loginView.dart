import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController userNameTextEditingController = TextEditingController();
  final TextEditingController passWordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(image: AssetImage('assets/images/Nottingham_Blue_white_text_logo_SCREEN.png'),)
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: userNameTextEditingController, 
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  labelText: "Username",
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true
                ),
              )
            ),
            
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(  
                controller: passWordTextEditingController, 
                obscureText: true, 
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  labelText: "Password",
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true
                ),
              )
            )
          ]
        )
      ),
    );
  }
}