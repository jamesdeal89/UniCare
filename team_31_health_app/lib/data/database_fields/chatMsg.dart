import 'package:team_31_health_app/data/database/database_attributes/data_model.dart';

class ChatMsg implements DataModel {
  final bool user;
  final String msg;
  ChatMsg(this.user,this.msg);

  @override
  Map<String, Object?> toMap(){
    // ? 1:0 converts boolean to integer for better json support / sqlite
    return {'user': user ? 1 : 0, 'message': msg};
  }
  @override
  String toString(){
    return 'Chat{user: $user, message: $msg}';
  }
}