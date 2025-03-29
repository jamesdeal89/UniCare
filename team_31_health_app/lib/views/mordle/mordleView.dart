import 'package:flutter/material.dart';

class MordleView extends StatefulWidget {
  const MordleView({super.key});

  @override
  State<MordleView> createState() => _MordleViewState();
}

class _MordleViewState extends State<MordleView> {

  final List<String> keyboardRows = [
    "QWERTYUIOP",
    "ASDFGHJKL",
    "ZXCVBNM"
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          "MORDLE",
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, 
        elevation: 2, 
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGrid(),
          const SizedBox(height: 20),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      children: List.generate(6, (row) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (col) {
            return Container(
              margin: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 99, 99, 99), width: 2),
              ),
            );
          }),
        );
      }),
    );

  }

  Widget _buildKeyboard() {
    return Column(
      children: keyboardRows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.split('').map((char) {
              return Padding(
                padding: const EdgeInsets.all(2), 
                child: ElevatedButton(
                  onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(25, 40),
                    backgroundColor: Color.fromARGB(255, 99, 99, 99), 
                  ),
                  child: Text(char),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
