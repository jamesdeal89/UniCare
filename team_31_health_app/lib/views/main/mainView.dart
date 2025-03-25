import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.book),
              text: "Journal",
            ),
            Tab(
              icon: Icon(Icons.healing),
              text: "Help",
            ),
            Tab(
              icon: Icon(Icons.chat_bubble),
              text: "Chat",
            ),
            Tab(
              icon: Icon(Icons.games),
              text: "Games",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Profile",
            )
          ],
          labelColor: Colors.grey,
          unselectedLabelColor: Colors.white,
        ),
      ),
    );
  }
}
