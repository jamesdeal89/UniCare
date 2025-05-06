import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/theme.dart';
import 'package:team_31_health_app/views/login/loginView.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final DatabaseService databaseService;
  // final ChatRepository chatRepository;
  const MyApp({super.key
  // , required this.chatRepository
  });
  
  
  
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      home: LoginView(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}