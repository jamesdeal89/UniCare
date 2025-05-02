import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:team_31_health_app/data/database/databaseService.dart';
import 'package:team_31_health_app/data/database_fields/chatMsg.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/botMsgError.dart';

class ChatRepo extends DatabaseService<ChatMsg> {
  ChatRepo({required super.database});
  String uid = "user";


  @override
  Future<List<ChatMsg>> get() async {
    // TODO: implement getMessages
    running = true;
    try {
      final List<Map<String,Object?>> messages = await database.query('chat');
      running = false;
      return [
        for (final {'id': _ as int, 'message': msg as String, 'user': user as int}
        in messages) 
        ChatMsg(user.isOdd, msg)
        ];
        
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }

  @override
  Future<ChatMsg> insert(ChatMsg message) async {
    try {
      await database.insert('chat', message.toMap());
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
    return message;
  }

  Future<ChatMsg> reply() async {  
    final List<Map<String,Object?>> lastMessages = await database.query('chat', limit: 1, orderBy: 'id DESC');
    List<ChatMsg> messages = [for (final {'id': _ as int, 'message': msg as String, 'user': user as int}
        in lastMessages) 
        ChatMsg(user.isOdd, msg)
        ];
    if(messages.isEmpty){
      throw BotMsgException();
    } else {
      final ChatMsg message = messages[0];
      if(message.user){
        // get the uid of the signed-in user - allows rasa server to recognise returning users.
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          print('User is signed in: ${currentUser.uid}');
          uid = currentUser.uid;
        } else {
          print('No user is signed in.');
          // create random username to keep chat privacy (only occurs if in Demo Mode.)
          // This will only set it once (per session.)
          // If the uid is not the default "user", this will not override it.
          // Means that even in Demo Mode, it'll keep a temporary session record of triggers, user access times, etc.
          if (uid == "user") {
            uid = generateRandomString(12);
          }
        }

        final response = await http.post(
          Uri.parse('http://35.246.77.137:5005/webhooks/rest/webhook'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'sender': uid, 'message': message.msg}),
        ).timeout(Duration(seconds: 10),onTimeout: (){
          throw TimeoutException("Bot timed out");
        });

        if (response.statusCode == 200) {
          print("SUCCESSFULLY RECEIVED FROM RASA");
          final List<dynamic> responseData = json.decode(response.body);
          for (var msg in responseData) {
              try {
                ChatMsg botMsg = ChatMsg(false,msg['text'].toString());
                print(msg.toString());
                await database.insert('chat', botMsg.toMap());
                running = false;
              } on Exception catch (_) {
                running = false;
                rethrow;
              }
          }
        } else {
          throw HttpException('Failed to send message');
        }
        running = true;
        return ChatMsg(false, "");
      } else {
        throw BotMsgException();
      }
    }
  }

  /// This is the function to clear this table from the database.
  Future<void> clear() async {
    try {
      await database.delete("chat");      
    } catch (e) {
      rethrow;
    }
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }
}