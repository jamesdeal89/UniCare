class ChatMsg {
  bool user;
  String msg;
  ChatMsg(this.user,this.msg);
  Map<String, Object?> toMap(){
    // ? 1:0 converts boolean to integer for better json support / sqlite
    return {'user': user ? 1 : 0, 'message': msg};
  }
  @override
  String toString(){
    return 'Chat{user: $user, message: $msg}';
  }
}