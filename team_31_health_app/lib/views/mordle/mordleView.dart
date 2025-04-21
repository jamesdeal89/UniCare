import 'dart:math';
import 'package:flutter/material.dart';

class MordleView extends StatefulWidget {
  const MordleView({super.key});

  @override
  State<MordleView> createState() => _MordleViewState();
}

class _MordleViewState extends State<MordleView> {
  final List<String> keyboardRows = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"];
  final int maxRows = 6;
  final int wordLength = 5;

  final Map<String, String> wordHints = {
  "Peace": "When everything feels still, like a quiet lake at dawn.",
  "Faith": "Believing in something, even when you can't see it.",
  "Smile": "A simple curve that can brighten someone’s day.",
  "Bloom": "A moment when nature quietly shows off its colors.",
  "Relax": "What you do when there’s nothing left to worry about.",
  "Shine": "It lights up the world, without making a sound.",
  "Heart": "Not just an organ — often linked with love and courage.",
  "Sweet": "Not sour, not bitter — something softer and kind.",
  "Grace": "It moves with ease, like a dancer or falling leaf.",
  "Happy": "You feel it when laughter comes easily."
};


  late String targetWord;

  List<List<String>> guesses = List.generate(6, (_) => List.filled(5, ""));
  List<List<Color>> tileColors = List.generate(6, (_) => List.filled(5, Colors.transparent));

  int currentRow = 0;
  int currentCol = 0;

  @override
  void initState() {
    super.initState();
    targetWord = wordHints.keys.elementAt(Random().nextInt(wordHints.length)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 38, 59, 1),
      appBar: AppBar(
        title: const Text(
          "MORDLE",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            tooltip: "Hint",
            onPressed: _showHint,
          )
        ],
      ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
      double gridHeight = screenHeight * 0.45;
      double keyboardHeight = screenHeight * 0.3;

      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SizedBox(
            height: gridHeight,
            child: Center(child: _buildGrid()),
          ),
          const Spacer(), 
          SizedBox(
            height: keyboardHeight,
            child: _buildKeyboard(),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showHint() {
    final hint = wordHints[targetWord[0] + targetWord.substring(1).toLowerCase()]!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hint"),
        content: Text(hint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      children: List.generate(maxRows, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(wordLength, (col) {
            return Container(
              margin: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                color: tileColors[row][col],
              ),
              child: Text(
                guesses[row][col].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        for (var row in keyboardRows.sublist(0, 2))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.split('').map((char) {
                return _buildKey(char);
              }).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSpecialKey("ENTER"),
              for (var char in keyboardRows[2].split('')) _buildKey(char),
              _buildSpecialKey("<----"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKey(String char) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => _onKeyTap(char),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(40, 50),
          backgroundColor: const Color.fromARGB(255, 199, 199, 199),
        ),
        child: Text(char),
      ),
    );
  }

  Widget _buildSpecialKey(String label) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () {
          if (label == "ENTER") {
            _onEnter();
          } else {
            _onBackspace();
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(90, 50),
          backgroundColor: const Color.fromARGB(255, 199, 199, 199),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

    void _resetGame() {
    setState(() {
      targetWord = wordHints.keys.elementAt(Random().nextInt(wordHints.length)).toUpperCase();
      guesses = List.generate(maxRows, (_) => List.filled(wordLength, ""));
      tileColors = List.generate(maxRows, (_) => List.filled(wordLength, Colors.transparent));
      currentRow = 0;
      currentCol = 0;
    });
  }


  void _onKeyTap(String char) {
    if (currentCol < wordLength && currentRow < maxRows) {
      setState(() {
        guesses[currentRow][currentCol] = char;
        currentCol++;
      });
    }
  }

  void _onBackspace() {
    if (currentCol > 0) {
      setState(() {
        currentCol--;
        guesses[currentRow][currentCol] = "";
      });
    }
  }

  void _onEnter() {
    if (currentCol < wordLength) return;

    String guess = guesses[currentRow].join().toUpperCase();
    String target = targetWord;
    List<Color> rowColors = List.filled(wordLength, Colors.grey[800]!);
    List<bool> used = List.filled(wordLength, false);

    for (int i = 0; i < wordLength; i++) {
      if (guess[i] == target[i]) {
        rowColors[i] = Colors.green;
        used[i] = true;
      }
    }

    for (int i = 0; i < wordLength; i++) {
      if (rowColors[i] == Colors.green) continue;
      for (int j = 0; j < wordLength; j++) {
        if (!used[j] && guess[i] == target[j]) {
          rowColors[i] = Colors.amber;
          used[j] = true;
          break;
        }
      }
    }

    setState(() {
      tileColors[currentRow] = rowColors;

      if (guess == target) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("You got it!"),
            content: const Text("Well done 🎉"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetGame();
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      } else if (currentRow == maxRows - 1) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Game Over"),
            content: Text("The word was: $target"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetGame();
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      } else {
        currentRow++;
        currentCol = 0;
      }
    });
  }

}