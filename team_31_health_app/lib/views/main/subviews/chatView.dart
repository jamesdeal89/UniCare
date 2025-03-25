import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Chat",
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
                        ),

                        // Start new chat button
                        // TODO: Implement functionality
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 8, 54, 97),
                        hintText: 'How are you today?',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 142, 142, 147),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // TODO: Implement send functionality
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
