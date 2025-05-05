import 'package:flutter/material.dart';
class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward()..repeat();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

  }

  @override
  void dispose() {
    animationController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,     
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              ( Container(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: Text("C")
              ))),
             
              
            Flexible(child: Container(
              
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onTertiaryFixed,
                borderRadius: BorderRadius.all(Radius.circular(10))),
              
                child: AnimatedIcon(icon: AnimatedIcons.ellipsis_search, progress: animation)
            ))
          ],
        )
        // child: 
      ));
    
  }
}

