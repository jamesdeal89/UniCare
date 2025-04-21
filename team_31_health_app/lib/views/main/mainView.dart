import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_31_health_app/data/chatRepo.dart';
import 'package:team_31_health_app/views/main/mainPage.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatMsg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  
  
  Future<Database> initDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), "care_app.db"),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT, user INTEGER)'
        );
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
            db.insert('chat', messages[i].toMap());
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
      body: FutureBuilder(future: initDB(), 
      builder: (context, AsyncSnapshot<Database> snapshot) {
        if(snapshot.hasData){
          ChatRepo(database: snapshot.data!);
          return MainPage(database: snapshot.data!);
        } else if(snapshot.hasError) {
          return IconButton(onPressed: () {
            setState(() {
              initDB();
            });
          }, icon: Icon(Icons.error));
        } else {
          return Text("Loading");
        }
      }
      )

    );
    
  }
}
