import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/pages/timerpage/goalselectionscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thinktank/services/firestore_user_creation.dart';


class MainStopwatchScreen extends StatefulWidget {
  late final String goal;
  late final int workingTime;
  late final int breakTime;
  late final String backgroundMusic;

  MainStopwatchScreen({super.key,
    required this.goal,
    required this.workingTime,
    required this.breakTime,
    required this.backgroundMusic,
  });

  @override
  _MainStopwatchScreenState createState() => _MainStopwatchScreenState();
}

class _MainStopwatchScreenState extends State<MainStopwatchScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isRunning = false;
  bool isMuted = false;
  late DateTime startTime;
  late DateTime currentTime;

  int currentWorkingTime = 0;
  int currentBreakTime = 0;
  bool isFirstStart = true;
  Timer? timer;
  final FirestoreUserCreationService _firestoreService = FirestoreUserCreationService();


  @override
  void initState() {
    super.initState();
    currentWorkingTime = widget.workingTime*60;
    currentBreakTime = widget.breakTime*60;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer({bool isBreakTimer = false}) {
    if (isBreakTimer == false){
      setState(() {
      isRunning = true;
      startTime = DateTime.now();
      currentTime = startTime;
      isFirstStart = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateTimer(isRunning: isRunning);
    });

    }
    else{
      setState(() {
        isRunning = false;
        startTime = DateTime.now();
        currentTime = startTime;
        isFirstStart = false;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        updateTimer(isRunning: isRunning);
      });

    }


  }


  void stopTimer() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      currentWorkingTime = widget.workingTime*60;
      currentBreakTime = widget.breakTime*60;
      isFirstStart = true;
    });
    timer?.cancel();
  }

  void updateTimer({bool isRunning = false}) {
    final now = DateTime.now();
    final difference = now.difference(currentTime);
    final int secondsPassed = difference.inSeconds;

    if (isRunning) {
        if (currentWorkingTime > 0) {
          currentWorkingTime -= secondsPassed;
          if (currentWorkingTime <= 0) {
            currentWorkingTime = 0;
            stopTimer();
            _firestoreService.saveWorkingTime(user?.uid ?? '', widget.workingTime);
          }
      }
    }
    else {

      if (currentBreakTime > 0) {
        currentBreakTime -= secondsPassed;
        if (currentBreakTime <= 0) {
          currentBreakTime = 0;
          showBreakTimeOverDialog();
          startWorkingTimer(); // Start the working timer after the break time is over
        }
      }
    }

    currentTime = now;
    setState(() {});
  }


  /*void updateTimer() {
    final now = DateTime.now();
    final difference = now.difference(currentTime);
    final int secondsPassed = difference.inSeconds;

    if (isRunning) {
      if (currentWorkingTime > 0) {
        currentWorkingTime -= secondsPassed;
        if (currentWorkingTime <= 0) {
          currentWorkingTime = 0;
          stopTimer();
          _firestoreService.saveWorkingTime(user?.uid ?? '', widget.workingTime);
          if (currentBreakTime <= 0) {
            showBreakTimeOverDialog();
            startWorkingTimer()
            // Call the function to save the working time
          } else {
            startBreakTimer();
          }
        }
      } else if (currentBreakTime > 0) {
        currentBreakTime -= secondsPassed;
        if (currentBreakTime <= 0) {
          currentBreakTime = 0;
          stopTimer();
          showBreakTimeOverDialog();
        }
      }
    }

    currentTime = now;
    setState(() {});
  }*/


  void showBreakTimeOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Break Time Over'),
          content: const Text('Your break time is over. Start working.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                startWorkingTimer();
              },
              child: const Text('Start Working'),
            ),
          ],
        );
      },
    );
  }
  void startBreakTimer() {
    // Set the break time duration and start the timer

    startTimer(isBreakTimer: true); // Pass isBreakTimer flag as true
  }

  void startWorkingTimer() {
    // Set the working time duration and start the timer
     // Stop break time
    startTimer(); // No need to pass isBreakTimer flag (default is false)
  }




  /*String formatTime(int time) {
    final int hours = time ~/ 60;
    final int minutes = time % 60;
    final int seconds = 0;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }*/

  String formatTime(int time) {
    final int hours = time ~/ 3600;
    final int minutes = (time % 3600) ~/ 60;
    final int seconds = time % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoalSelectionScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                  ),
                  child: Row(mainAxisAlignment:MainAxisAlignment.center ,
                    children: [
                      Text(
                        widget.goal,
                        style: const TextStyle(
                          color: Color(0xFF37352F),
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.add, size: 20),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: buildTimerSection(
                      currentWorkingTime > 0 ? currentWorkingTime : currentBreakTime,
                      "Çalışma",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: buildTimerSection(
                      currentBreakTime > 0 ? currentBreakTime : currentWorkingTime,
                      "Ara",
                      isBreakTimer: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isFirstStart)
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: IconButton(
                          onPressed: resetTimer,
                          icon: const Icon(
                            Icons.refresh_sharp,
                            size: 25,
                          ),
                        ),
                      ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFE7E7E6),
                        shape: OvalBorder(),
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF37352F),
                            blurRadius: 10,
                            offset: Offset(2, 6),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isRunning) {
                           // print("pressed durdur");
                            stopTimer();
                            startBreakTimer();
                          } else {
                            if(isFirstStart==true) {
                              startTimer();
                            }
                            else
                              {
                                stopTimer();
                                startWorkingTimer();
                              }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          isRunning ? 'Durdur' : 'Başlat',
                          style: const TextStyle(
                            color: Color(0xFF37352F),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    if (!isFirstStart)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isMuted = !isMuted;
                            });
                          },
                          icon: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                            size: 25,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  /*Widget buildTimerSection(int time, String label, {bool isBreakTimer = false}) {
    final String formattedTime = formatTime(time);
    final double fontSize = isBreakTimer ? 32.0 : 40.0;
    final Color backgroundColor = isBreakTimer ?  const Color.fromARGB(1,232,232,232) : const Color.fromARGB(1,232,232,232);
    final double circleSize = isBreakTimer ? 150.0 : 250.0;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: ShapeDecoration(
        color: Color(0xFFE7E7E6),
        shape: OvalBorder(),
        shadows: [
          BoxShadow(
            color: Color(0xFF37352F),
            blurRadius: 10,
            offset: Offset(2, 6),
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text( //silinebilir
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }*/
  Widget buildTimerSection(int time, String label, {bool isBreakTimer = false}) {
    final String formattedTime = formatTime(time);
    final double fontSize = isBreakTimer ? 32.0 : 40.0;
    //final Color backgroundColor = isBreakTimer ? Color.fromARGB(1, 232, 232, 232) : Color.fromARGB(1, 232, 232, 232);
    final double circleSize = isBreakTimer ? 150.0 : 250.0;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: const ShapeDecoration(
        color: Color(0xFFE7E7E6),
        shape: OvalBorder(),
        shadows: [
          BoxShadow(
            color: Color(0xFF37352F),
            blurRadius: 10,
            offset: Offset(2, 6),
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Çıkmak istediğinize emin misiniz"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          print('yes selected');
                          _firestoreService.saveWorkingTime(user?.uid ?? '', (currentWorkingTime-widget.workingTime));
                           // Call the function to save the working time
                          Navigator.of(context).popUntil((route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                        child: const Text("Evet"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop(false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("Hayır", style: TextStyle(color: Colors.black)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
