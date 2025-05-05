import 'package:flutter/material.dart';
import 'package:team_31_health_app/views/main/subviews/games/mordleView.dart';
import 'package:team_31_health_app/views/main/subviews/games/inhaleView.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Expanded(flex: 2, child: Icon(Icons.abc, size: 50)),
                          Expanded(
                            flex: 8,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MordleView()),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Mordle", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                  Text("An uplifting twist on a household name"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
              Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Expanded(flex: 2, child: Icon(Icons.air, size: 50)),
                          Expanded(
                            flex: 8,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const InhaleView()),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Inhail", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                  Text("Breathing exercises for stress and anxiety"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
