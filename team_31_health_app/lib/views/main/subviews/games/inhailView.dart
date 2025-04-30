import 'package:flutter/material.dart';
import 'dart:async';

class InhailView extends StatefulWidget {
  const InhailView({super.key});

  @override
  State<InhailView> createState() => _InhailViewState();
}

class BreathingExercise{
  final int inhale;
  final int hold;
  final int exhale;
  final int cycles;
  final String name;
  BreathingExercise({ 
    required this.inhale,
    required this.hold,
    required this.exhale,
    required this.cycles,
    required this.name}
  );
}

class _InhailViewState extends State<InhailView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Inhail')),
      body :  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Card(

                margin: EdgeInsets.only(bottom:16),
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
                              MaterialPageRoute(builder: (context) => InhailSession(
                                exercise: BreathingExercise(
                                  inhale: 6, 
                                  hold: 0, 
                                  exhale: 6, 
                                  cycles: 5,
                                  name: 'Coherent Breathing'),
                                )),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text("Coherent Breathing", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              Text("Relieves stress and anxiety"),
                            ],
                          ),
                        ),
                      ),
                  ],)
                  )
              ),

              Card(      
                margin: EdgeInsets.only(bottom:16),
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
                              MaterialPageRoute(builder: (context) => InhailSession(
                                exercise: BreathingExercise(
                                  inhale: 4, 
                                  hold: 4, 
                                  exhale: 4, 
                                  cycles:5,
                                  name: 'Box Breathing'),
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
                  ],)
                  )
              ),


              Card(
                
                
                margin: EdgeInsets.only(bottom:16),
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
                              MaterialPageRoute(builder: (context) => InhailSession(
                                exercise: BreathingExercise(
                                  inhale: 4, 
                                  hold: 7,
                                  exhale: 8, 
                                  cycles: 3,
                                  name: '4-7-8 Breathing'),
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
                  ],)
                  )
              ),
            ]
        
      ),  //Scaffold 
        )
      )
    );
}
}

class InhailSession extends StatefulWidget {
  final BreathingExercise exercise;

  const InhailSession({super.key, required this.exercise});

  @override 
  State<InhailSession> createState() => _InhailSessionState();
}

class _InhailSessionState extends State<InhailSession> {
  late int timeLeft;
  late Timer timer;
  String phase = 'INHALE';
  int cyclesCompleted = 0;
  late int maxCycles;

  @override
  void initState(){
    super.initState();
    timeLeft = widget.exercise.inhale;
    maxCycles = widget.exercise.cycles;
    startTimer();
  }

  void startTimer(){
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
  

  void nextPhase(){
    if (phase == 'INHALE'){
      if (widget.exercise.hold > 0){
        phase = 'HOLD';
        timeLeft = widget.exercise.hold;
      } else {
        phase = 'EXHALE';
        timeLeft = widget.exercise.exhale;
      }
    } else if (phase == 'HOLD'){
      phase = 'EXHALE';
      timeLeft = widget.exercise.exhale;
    } else if (phase == 'EXHALE'){
      cyclesCompleted++;
      if (cyclesCompleted < maxCycles){
        phase = 'INHALE';
        timeLeft = widget.exercise.inhale;
      } else {
        timer.cancel();
        phase = 'DONE';
      }
    }

  }
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }
  

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:
       Text(widget.exercise.name)
      ),
      body: Center(
        child: phase == 'DONE'
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Session Complete", 
                style: TextStyle(
                  fontSize:36)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cyclesCompleted = 0;
                        phase = 'INHALE';
                        timeLeft = widget.exercise.inhale;
                        startTimer();
                      });

                    },
                    child: const Text("Start Again"),
                  ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Back to Menu"),
                      ),
              ],
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  phase,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                    ),
                    Text('$timeLeft seconds',
                    style: const TextStyle(fontSize:48),
                    ),
                    Text('Cycle ${cyclesCompleted + 1} of $maxCycles'),
              ],)
           // Add a fallback widget for other phases
      ),
    );
  }
}
