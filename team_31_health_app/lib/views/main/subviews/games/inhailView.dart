import 'package:flutter/material.dart';
import 'dart:async';

class InhailView extends StatefulWidget {
  const InhailView({super.key});

  @override
  State<InhailView> createState() => _InhailViewState();
}

class BreathingExercise {
  final int inhale;
  final int inhaleHold;
  final int exhale;
  final int exhaleHold;
  final int cycles;
  final String name;
  BreathingExercise({required this.inhale, required this.inhaleHold, required this.exhale, required this.cycles, required this.exhaleHold, required this.name});
}

class _InhailViewState extends State<InhailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          title: Text(
            "Inhail",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Card(
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InhaleSession(
                                          exercise: BreathingExercise(inhale: 6, inhaleHold: 0, exhale: 6, exhaleHold: 0, cycles: 5, name: 'Coherent Breathing'),
                                        )),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Coherent Breathing", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                Text("Relieves stress and anxiety"),
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
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InhaleSession(
                                          exercise: BreathingExercise(inhale: 4, inhaleHold: 4, exhale: 4, exhaleHold: 4, cycles: 4, name: 'Box Breathing'),
                                        )),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Box Breathing", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                Text("Reduce stress, enhance focus"),
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
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InhaleSession(
                                          exercise: BreathingExercise(inhale: 4, inhaleHold: 7, exhale: 8, exhaleHold: 0, cycles: 3, name: '4-7-8 Breathing'),
                                        )),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("4-7-8 Breathing", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                Text("Promotes Relaxation"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          ]), //Scaffold
        )));
  }
}

class InhaleSession extends StatefulWidget {
  final BreathingExercise exercise;

  const InhaleSession({super.key, required this.exercise});

  @override
  State<InhaleSession> createState() => _InhaleSessionState();
}

class _InhaleSessionState extends State<InhaleSession> {
  late int timeLeft;
  late Timer timer;
  late String phase;
  int cyclesCompleted = 0;
  late int maxCycles;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.exercise.inhale;
    maxCycles = widget.exercise.cycles;
    phase = 'INHALE';
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          nextPhase();
        }
      });
    });
  }

  void nextPhase() {
    if (phase == 'INHALE') {
      if (widget.exercise.inhaleHold > 0) {
        phase = 'INHALE_HOLD';
        timeLeft = widget.exercise.inhaleHold;
      } else {
        phase = 'EXHALE';
        timeLeft = widget.exercise.exhale;
      }
    } else if (phase == 'INHALE_HOLD') {
      phase = 'EXHALE';
      timeLeft = widget.exercise.exhale;
    } else if (phase == 'EXHALE'){
      if (widget.exercise.exhaleHold > 0) {
        phase = 'EXHALE_HOLD';
        timeLeft = widget.exercise.exhaleHold;
      } else {
       incrementCycle();
      }
    } else if (phase == 'EXHALE_HOLD') {
      incrementCycle();
      }
  }
    

  void incrementCycle(){
    cyclesCompleted++;
    if (cyclesCompleted < maxCycles) {
      phase = 'INHALE';
      timeLeft = widget.exercise.inhale;
    } else {
      timer.cancel();
      phase = 'DONE';
    }
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.exercise.name,
        style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSurface),
      )),
      body: Center(
          child: phase == 'DONE'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Session Complete", style: TextStyle(fontSize: 36)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cyclesCompleted = 0;
                          phase = 'INHALE';
                          timeLeft = widget.exercise.inhale;
                          startTimer();
                        });
                      },
                      child: Text("Start Again", style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSurface)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back to Menu", style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSurface)),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (phase == 'INHALE_HOLD' || phase == 'EXHALE_HOLD') ? 'HOLD' : phase,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$timeLeft seconds',
                      style: const TextStyle(fontSize: 48),
                    ),
                    Text('Cycle ${cyclesCompleted + 1} of $maxCycles'),
                  ],
                )
          // Add a fallback widget for other phases
          ),
    );
  }
}
