import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/subviews/chat/components/chatbubble.dart';

class ChatMsg {
  bool user;
  String msg;
  ChatMsg(this.user, this.msg);
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  final TextEditingController msgTextEditingController = TextEditingController();
  final ScrollController chatScrollController = ScrollController();

  // Arrange from most recent to least recent
  List<ChatMsg> messages = <ChatMsg>[
    ChatMsg(true, "Newest"),
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
    ChatMsg(true, "Oldest"),
  ];
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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Chat",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
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
                  floatingActionButton: shouldShowScrollButton
                      ? FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 10, 132, 255),
                          child: Icon(Icons.arrow_downward_rounded),
                          onPressed: () {
                            chatScrollController.animateTo(chatScrollController.position.minScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
                          })
                      : null,
                  body: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                          reverse: true,
                          controller: chatScrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return ChatBubble(message: messages[index].msg, user: messages[index].user);
                          })))),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
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
                  onPressed: () {
                    // TODO: Implement send functionality
                    // This should send the text in the text field to the chat
                    setState(() {
                      messages.add(ChatMsg(true, msgTextEditingController.text));
                      msgTextEditingController.clear();
                      messages.add(ChatMsg(false, "..."));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
