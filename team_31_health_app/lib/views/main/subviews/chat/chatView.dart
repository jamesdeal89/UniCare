import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/chatRepo.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatMsg.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatbubble.dart';


class ChatView extends StatefulWidget {

  const ChatView({super.key, required this.chatRepo});

  final ChatRepo chatRepo;

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
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
  // late ChatRepository chatRepo;
  
  @override
  void initState() {
    super.initState();
    // chatRepo = ChatRepository(databaseFactory: databaseFactory);
  }
  Future<List<ChatMsg>> getMessages() async {
      return (await widget.chatRepo.get()).reversed.toList();
  }
  Future<ChatMsg> sendMessage(ChatMsg message) async {
      return (await widget.chatRepo.insert(message));
  }

  void _listener(ScrollNotification scrollNotification) {
    if(scrollNotification.metrics.extentAfter > (0.9 * MediaQuery.sizeOf(context).height)){
      // only call setState if the value has changed
      if(!shouldShowScrollButton){
        setState(() {
          shouldShowScrollButton = true;
        });
      }
    } else {
      if(shouldShowScrollButton){
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.hasData){
        List<ChatMsg> messages = snapshot.data!;
          return Scaffold( 
            body: Column(
              children: <Widget>[
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child:
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
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
                    floatingActionButton: shouldShowScrollButton ? 
                    FloatingActionButton(
                      backgroundColor: Color.fromARGB(255, 10, 132, 255),
                      child: Icon(Icons.arrow_downward_rounded),
                      onPressed: () {                  
                        chatScrollController.animateTo(
                          chatScrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceInOut
                        );
                      }
                    ) : null,

                    body: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        reverse: false,
                        controller: chatScrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return
                            ChatBubble(message: messages[index].msg, user: messages[index].user);
                        }
                        )
                      )
                    )
                  ),


                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(

                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: msgTextEditingController,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                fillColor: const Color.fromARGB(255, 8, 54, 97),
                                hintText: 'How are you today?',
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            // This should send the text in the text field to the chat
                              // messages.add();
                              String text = msgTextEditingController.text;
                              msgTextEditingController.clear();
                              await sendMessage(ChatMsg(true, text));
                              setState(() {

                              });
                          },
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          );
      } else if(snapshot.hasError) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            child: TextButton(
              onPressed: () {
                setState(() {
            
                });
              }, child: Text("Retry"),
            ),
            
          )]);
      }
      else {
        return Container();
      }
    }, future: getMessages());

  }
}
