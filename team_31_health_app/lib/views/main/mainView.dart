import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/subviews/chatView.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainView();
}

//TODO: Add functionality with switching views with the bottom navigation bar

class _MainView extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 142, 142, 147),
        selectedItemColor: Color.fromARGB(255, 10, 132, 255),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Journal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: "Help",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
