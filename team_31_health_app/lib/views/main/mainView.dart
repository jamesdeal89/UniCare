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
  /// This command
  Future<Database> initDB() async {
    String key = ((currentUser?.uid) != null) ? currentUser!.uid : "";
    final database = await openDatabase(
      join(await getDatabasesPath(), "care_app$key.db"),
      
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, user INTEGER)');
        List<ChatMsg> messages = <ChatMsg>[
          ChatMsg(true, "Oldest"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Yeah"),
          ChatMsg(true, "Hello"),
          ChatMsg(false, "World"),
          ChatMsg(true, "Newest"),
        ];
        for (var i = 0; i < messages.length; i++) {
          await db.insert('chat', messages[i].toMap());
          await db.insert('chat', messages[i].toMap());
        }
        await db.execute('CREATE TABLE journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, description TEXT, give INTEGER, takeNotice INTEGER, keepLearning INTEGER, beActive INTEGER, connect INTEGER)');
        List<JournalEntry> journalEntries = <JournalEntry>[
          JournalEntry(title: "Titledsadfsaf", date: DateTime.now(), description: "Description", give: true, takeNotice: true, keepLearning: true, beActive: true, connect: true),
          JournalEntry(title: "Titledasfasfd", date: DateTime.now(), description: "Description2", give: true, takeNotice: false, keepLearning: true, beActive: true, connect: true),
          JournalEntry(title: "Titlasccccccccccae", date: DateTime.now(), description: "Description3", give: true, takeNotice: true, keepLearning: false, beActive: true, connect: true),
          JournalEntry(title: "Ticcccccccccatle", date: DateTime.now(), description: "Description4", give: true, takeNotice: true, keepLearning: true, beActive: false, connect: true),
          JournalEntry(title: "Titlcccccccae", date: DateTime.now(), description: "Description5", give: true, takeNotice: true, keepLearning: true, beActive: true, connect: false),
          JournalEntry(title: "Titaaaaaaaaaaale", date: DateTime.now(), description: "Description6", give: true, takeNotice: true, keepLearning: true, beActive: true, connect: true),
          JournalEntry(title: "Titldasdadwqwdwqdsasdsadawqe", date: DateTime.now(), description: "Description7", give: false, takeNotice: true, keepLearning: true, beActive: true, connect: true),
        ];
        for (var i = 0; i < journalEntries.length; i++) {
          await db.insert('journal_entries', journalEntries[i].toMap());
        }
      },
      version: 1,
    ).then((db){
      db.execute("sql");
    });
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
            builder: (context, AsyncSnapshot<Database> snapshot) {
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

