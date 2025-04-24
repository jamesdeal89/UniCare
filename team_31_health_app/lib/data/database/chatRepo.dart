import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:team_31_health_app/data/database/databaseService.dart';
import 'package:team_31_health_app/data/database_fields/chatMsg.dart';

class ChatRepo extends DatabaseService<ChatMsg> {
  ChatRepo({required super.database});


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
    final List<Map<String,Object?>> lastMessages = await database.query('chat', limit: 1, orderBy: 'id');
    List<ChatMsg> messages = [for (final {'id': _ as int, 'message': msg as String, 'user': user as int}
        in lastMessages) 
        ChatMsg(user.isOdd, msg)
        ];
    final ChatMsg message = messages[0];
    if(message.user){
      final response = await http.post(
        Uri.parse('http://35.246.77.137:5005/webhooks/rest/webhook'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sender': 'user', 'message': message.msg}),
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
              return botMsg;
            } on Exception catch (_) {
              running = false;
              rethrow;
            }
        }
      } else {
        throw HttpException('Failed to send message');
      }
      running = true;
      return message;
    }
    throw HttpException("No reply");
  }

  /// This is the function to clear this table from the database.
  Future<void> clear() async {
    try {
      await database.delete("chat");      
    } catch (e) {
      rethrow;
    }
  }
}