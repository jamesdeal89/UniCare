import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_31_health_app/data/database_fields/chatMsg.dart';
import 'package:team_31_health_app/data/database_fields/journalEntry.dart';
import 'package:team_31_health_app/views/main/mainPage.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  /// This command initialises the Database with queries. Use lists of [DataModel] 
  /// objects to fill their respective tables.
  Future<Database> initDB() async {
    String key = ((currentUser?.uid) != null) ? currentUser!.uid : "";
    final database = await openDatabase(
      join(await getDatabasesPath(), "care_app$key.db"),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, user INTEGER)');
        List<ChatMsg> messages = <ChatMsg>[
          ChatMsg(false, "Welcome! Feel free to talk about your day! I'm here to help! :)"),
        ];
        for (var i = 0; i < messages.length; i++) {
          await db.insert('chat', messages[i].toMap());
        }
        await db.execute('CREATE TABLE journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, description TEXT, give INTEGER, takeNotice INTEGER, keepLearning INTEGER, beActive INTEGER, connect INTEGER)');
        List<JournalEntry> journalEntries = <JournalEntry>[
          JournalEntry(title: "Downloaded UniCare", date: DateTime.now(), description: "Welcome to UniCare, the #1 way for University of Nottingham students to take care of their mental wellbeing!", give: false, takeNotice: false, keepLearning: false, beActive: false, connect: false),
        ];
        for (var i = 0; i < journalEntries.length; i++) {
          await db.insert('journal_entries', journalEntries[i].toMap());
        }
      },
      version: 1,
    );
    return database;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: initDB(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Text("Loading");
              } else if (snapshot.hasError || !snapshot.hasData) {
                return IconButton(
                    onPressed: () {
                      setState(() {
                        initDB();
                      });
                    },
                    icon: Icon(Icons.error));
              } else {
                return MainPage(database: snapshot.data!);
              }
            }));
  }
}
