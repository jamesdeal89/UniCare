import 'dart:math';
import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/subviews/games/mordleView.dart';
import 'package:team_31_health_app/views/main/subviews/games/inhailView.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 80),
                  foregroundColor: Colors.black,
                  shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MordleView()),
                  );
                },
                child: const Text('Mordle'),
              ),
              const SizedBox(height: 20), // space between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 80),
                  foregroundColor: Colors.black,
                  shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InhailView()),
                  );
                },
                child: const Text('Inhail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


