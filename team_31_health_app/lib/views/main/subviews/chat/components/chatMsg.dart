class ChatMsg {
  bool user;
  String msg;
  ChatMsg(this.user,this.msg);
  Map<String, Object?> toMap(){
    return {'user': user, 'message': msg};
  }
  @override
  String toString(){
    return 'Chat{user: $user, message: $msg}';
  }
}