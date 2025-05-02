import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/database/chatRepo.dart';
import 'package:team_31_health_app/data/database_fields/chatMsg.dart';
import 'package:team_31_health_app/data/result.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/botMsgError.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatbubble.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/typingbubble.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.chatRepo});

  final ChatRepo chatRepo;

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView>{
  final TextEditingController msgTextEditingController = TextEditingController();
  final ScrollController chatScrollController = ScrollController();

  bool shouldShowScrollButton = false;
  ScrollNotificationObserverState? notificationObserverState;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    notificationObserverState?.removeListener(_listener);
    notificationObserverState = ScrollNotificationObserver.maybeOf(context);
    notificationObserverState?.addListener(_listener);
  }

  late Future<Result<ChatMsg>> replyMessage;

  Future<void> _refreshMessages() async {
    // re-trigger bot to load several messages - (kinda forceful work-around, sorry)
    if (msgTextEditingController.text.isEmpty) {
      msgTextEditingController.text = " ";
      msgTextEditingController.text = "";
    } else {
      msgTextEditingController.text += " ";
      msgTextEditingController.text =
          msgTextEditingController.text.trim();
    }

    if (formKey.currentState != null) {
      formKey.currentState!.validate();
    }
    setState(() {});
  }
  late Future<List<ChatMsg>> chatMessages;
  @override
  void initState() {
    super.initState();
    chatMessages = getMessages();
    
    replyMessage = reply();
  }

  Future<List<ChatMsg>> getMessages() async {
    try {
      return (await widget.chatRepo.get()).reversed.toList();
    } catch (_) {
      rethrow;
    }
    
  }

  Future<ChatMsg> sendMessage(ChatMsg message) async {
    try {
      return(await widget.chatRepo.insert(message));
    } catch (_) {
      rethrow;
    }
    
  }

  Future<void> deleteChat() async {
    try {
      return (await widget.chatRepo.clear());
    } catch (e) {
      rethrow;
    }
  }
  Future<Result<ChatMsg>> reply() async {
    
    try {
      
      // return await Future.delayed(Duration(seconds: 4), () async {
      //         return await sendMessage(ChatMsg(false, "test"));
      //       });
        
      // PROD: enable for BOT USE.
      ChatMsg msg = await widget.chatRepo.reply();
      setState(() {
        _refreshMessages();
        chatMessages = getMessages();
      });
      return Result.ok(msg);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  void _listener(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.extentBefore > (0.33 * MediaQuery.sizeOf(context).height)) {
      // only call setState if the value has changed
      if (!shouldShowScrollButton) {
        setState(() {
          shouldShowScrollButton = true;
        });
      }
    } else {
      if (shouldShowScrollButton) {
        // only call setState if the value has changed
        setState(() {
          shouldShowScrollButton = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chatScrollController.dispose();
    super.dispose();
    notificationObserverState?.removeListener(_listener);
  }

  final ScrollController _chatMsgScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  void Function()? submitMsg;
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
                return Text("Loading");
          } else if (snapshot.hasError || !snapshot.hasData) {
                return IconButton(
                    onPressed: () {
                      setState(() {
                        chatMessages = getMessages();
                        // initDB();
                      });
                    },
                    icon: Icon(Icons.error));
          } else {
            List<ChatMsg> messages = snapshot.data!;
            return Scaffold(
              body: Column(
                children: <Widget>[
                  
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(top: 32, left: 20, right: 32, bottom: 20),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: const Color.fromRGBO(255, 255, 255, 0.1), width: 3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Chat",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  await deleteChat();
                                  setState(() {
                                    this.chatMessages = getMessages();

                                  });
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                )
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                      child: Scaffold(
                          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
                          floatingActionButton: shouldShowScrollButton
                              ? FloatingActionButton(
                                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                                  child: Icon(Icons.arrow_downward_rounded, color: Theme.of(context).iconTheme.color),
                                  onPressed: () {
                                    setState(() {
                                      replyMessage = reply();
                                      
                                    });
                                    chatScrollController.animateTo(chatScrollController.position.minScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
                                  })
                              : null,
                          body: Container(
                              padding: EdgeInsets.all(10),
                              
                              child: ListView.builder(
                                  reverse: true,
                                  controller: chatScrollController,
                                  itemCount: messages.length+1,
                                  itemBuilder: (context, idx) {

                                    if(idx == 0){
                                      return FutureBuilder(future: replyMessage, builder: (context, snapshot) {
                                        print(snapshot);
                                        print(snapshot.error);
                                        
                                        if (snapshot.connectionState != ConnectionState.done) {
                                          return TypingBubble();
                                        } else if(snapshot.hasData) {
                                          final result = snapshot.data;
                                          switch (result) {
                                            case Ok<ChatMsg>():
                                              ChatMsg message = result.value;
                                              return ChatBubble(message: message.msg, user: false);
                                              
                                            case Error<BotMsgException>():
                                              return Container();
                                            case Error<Exception>():
                                              return IconButton(icon: Icon(Icons.refresh), onPressed: () {
                                                setState(() {
                                                  
                                                  replyMessage = reply();
                                                });
                                              });
                                            default:
                                              return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      }); 
                                    } else {
                                      int index = idx-1;

                                      return ChatBubble(message: messages[index].msg, user: messages[index].user);
                                    }
                                  })))),
                  

                  TapRegion(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1), width: 3))),
                        padding: EdgeInsets.all(20),
                        child: Form(
                            key: formKey,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 11),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: Theme.of(context).inputDecorationTheme.fillColor,
                                    ),
                                    child: Scrollbar(
                                        controller: _chatMsgScrollController,
                                        child: TextFormField(
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              if (value.length > 200) {
                                                return 'Message is too long';
                                              }
                                              return null;
                                            },
                                            style: Theme.of(context).textTheme.bodyMedium,
                                            controller: msgTextEditingController,
                                            minLines: 1,
                                            maxLines: 5,
                                            maxLength: 200,
                                            scrollController: _chatMsgScrollController,
                                            onChanged: (value) {
                                              setState(() {
                                                submitMsg = (formKey.currentState!.validate())
                                                    ? () async {
                                                        if (formKey.currentState!.validate()) {
                                                          // This should send the text in the text field to the chat
                                                          // messages.add();
                                                          String text = msgTextEditingController.text;
                                                          msgTextEditingController.clear();
                                                          try {
                                                            print("called");
                                                            await sendMessage(ChatMsg(true, text));
                                                            setState(() {
                                                              reply();
                                                            });
                                                          } catch (_) {
                                                            return;
                                                          }
                                                        } else {
                                                          return;
                                                        }
                                                      }
                                                    : null;
                                              });
                                            },
                                            decoration: InputDecoration(hintText: 'How are you today?', errorStyle: TextStyle(height: 0, fontSize: 0, color: Colors.transparent), hintStyle: Theme.of(context).inputDecorationTheme.hintStyle, border: InputBorder.none))),
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.send), onPressed: submitMsg),
                              ],
                            )),
                      )),
                ],
              ),
            );
          }
        },
        future: chatMessages);
  }
}
