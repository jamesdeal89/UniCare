import 'dart:math';
import 'package:flutter/material.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  final List<String> keyboardRows = [
    "QWERTYUIOP",
    "ASDFGHJKL",
    "ZXCVBNM"
  ];
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Mordle",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            tooltip: "Hint",
            onPressed: _showHint,
            color: Theme.of(context).colorScheme.tertiary,
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
                border: Border.all(color: Theme.of(context).colorScheme.onPrimary, width: 2),
                color: tileColors[row][col],
              ),
              child: Text(
                guesses[row][col].toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
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
    return LayoutBuilder(builder: (context, constraints) {
      final keyWidth = (constraints.maxWidth - 24) / 10;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyboardRows[0].split('').map((char) {
                return _buildKey(char, keyWidth);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyboardRows[1].split('').map((char) {
                return _buildKey(char, keyWidth);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (() {
                List<Widget> rowButtons = [];
                rowButtons.add(_buildSpecialKey("ENTER", keyWidth * 1.5));
                final letterKeys = keyboardRows[2].split('').map((char) {
                  return _buildKey(char, keyWidth);
                }).toList();
                rowButtons.addAll(letterKeys);
                rowButtons.add(_buildSpecialKey("<----", keyWidth * 1.5));
                return rowButtons;
              })(),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildKey(String char, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => _onKeyTap(char),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: Text(
          char,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String label, double width) {
    return Container(
      width: width,
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
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
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
