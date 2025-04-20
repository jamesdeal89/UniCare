import 'package:team_31_health_app/data/databaseService.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatMsg.dart';

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
        for (final {'id': id as int, 'message': msg as String, 'user': user as int}
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
    // TODO: implement insertMessage
    
    running = true;
    try {
      await database.insert('chat', message.toMap());
      running = false;
      return message;
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }
}