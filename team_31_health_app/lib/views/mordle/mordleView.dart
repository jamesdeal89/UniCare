import 'package:flutter/material.dart';

class MordleView extends StatefulWidget {
  const MordleView({super.key});

  @override
  State<MordleView> createState() => _MordleViewState();
}

class _MordleViewState extends State<MordleView> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          "MORDLE",
          style: TextStyle(
            fontSize: 24, // Looks bold like the Wordle title
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, 
        elevation: 2, 
      ),
      body: Column(
        children: [
        ],
      ),
      
    );
  }
}
