import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/mainView.dart';
import 'package:team_31_health_app/views/login/privacyView.dart';
import 'package:team_31_health_app/data/theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key
      // , required this.chatRepository
      });
  // final ChatRepository chatRepository;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController userNameTextEditingController = TextEditingController();
  final TextEditingController passWordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkMode,
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
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
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: userNameTextEditingController,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      labelText: "Email",
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: passWordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      labelText: "Password",
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
                child: Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
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

                      // Navigate to mainView on login success
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainView()),
                      );

                      // In case of error...
                    } on FirebaseAuthException catch (_) {
                      // Close loading + show error
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Incorrect login credentials. Please check your email and password."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                ))),
            /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
                child: Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainView()),
                    );
                  },
                  child: Text("Demo Mode"),
                ))),
            */
            // priv policy
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
                child: Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PrivacyView()),
                    );
                  },
                  child: Text("Privacy Policy"),
                )))
          ])),
        );
      }),
    );
  }
}
