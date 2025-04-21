import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool user;
  const ChatBubble({
    super.key,
    required this.message,
    required this.user
    });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: user ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!user)
              Container(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: Text("C")
              )),
             
              
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: user ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.onTertiaryFixed,
                borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                softWrap: true,
                      message,
                      style: user ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.bodyMedium,
                    ),  
            )
          ],
        )
        // child: 
      );
    
  }
}