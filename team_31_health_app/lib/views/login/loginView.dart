import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/mainView.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Padding(
            padding: EdgeInsets.all(20),
            child: Image(
              image: AssetImage('assets/images/Nottingham_Blue_white_text_logo_SCREEN.png'),
            )),
        Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: userNameTextEditingController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Username", fillColor: Theme.of(context).colorScheme.primary, filled: true),
            )),
        Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: passWordTextEditingController,
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password", fillColor: Theme.of(context).colorScheme.primary, filled: true),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
            child: Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
<<<<<<< team_31_health_app/lib/views/login/loginView.dart
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainView()),
                );
=======
              onPressed: () async {
                try {
                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  );

                  // Sign in with Firebase
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: userNameTextEditingController.text.trim(),
                    password: passWordTextEditingController.text.trim(),
                  );

                  // Close loading
                  Navigator.of(context).pop();

                  // Navigate to home
                  Navigator.of(context).pushReplacementNamed('/home');
                } on FirebaseAuthException catch (e) {
                  // Close loading
                  Navigator.of(context).pop();

                  // Show error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.message ?? 'Authentication failed. Please try again.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
>>>>>>> team_31_health_app/lib/views/login/loginView.dart
              },
              child: Text("Login"),
            )))
      ])),
    );
  }
}
