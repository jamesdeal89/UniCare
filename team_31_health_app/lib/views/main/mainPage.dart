import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:team_31_health_app/data/database/chatRepo.dart';
import 'package:team_31_health_app/data/database/journalRepo.dart';
import 'package:team_31_health_app/views/main/subviews/chat/chatView.dart';
import 'package:team_31_health_app/views/main/subviews/games/gamesView.dart';
import 'package:team_31_health_app/views/main/subviews/helpView.dart';
import 'package:team_31_health_app/views/main/subviews/journal/journalView.dart';
import 'package:team_31_health_app/views/main/subviews/profile/profileView.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.database});
  final Database database;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;
  late Database database;
  late ChatRepo chatRepo;
  late JournalRepo journalRepo;

  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    database = widget.database;
    chatRepo = ChatRepo(database: database);
    journalRepo = JournalRepo(database: database);
    _widgetOptions = <Widget>[
      JournalView(journalRepo: journalRepo),
      const HelpView(),
      ChatView(chatRepo: chatRepo),
      const GamesView(),
      ProfileView(journalRepo: journalRepo),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 142, 142, 147),
        selectedItemColor: Color.fromARGB(255, 10, 132, 255),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
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
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
