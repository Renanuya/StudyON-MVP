import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/core/constants/navigation/navigation_constants.dart';
import 'package:thinktank/core/utils/navigation/navigation_service.dart';
import 'package:thinktank/services/firestore_user_creation.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'goalselectionscreen.dart';

class MainStopwatchScreen extends StatefulWidget {
  final String goal;
  final int workingTime;
  final int breakTime;
  final String backgroundMusic;

  const MainStopwatchScreen({
    Key? key,
    required this.goal,
    required this.workingTime,
    required this.breakTime,
    required this.backgroundMusic,
  }) : super(key: key);

  @override
  _MainStopwatchScreenState createState() => _MainStopwatchScreenState();
}

class _MainStopwatchScreenState extends State<MainStopwatchScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isMuted = false;
  bool isBreakTimer = false;
  bool result = false;
  int currentWorkingTime = 0;
  int currentBreakTime = 0;
  bool isFirstStart = true;
  bool isFirstBreak = true;
  bool isWorking = false;
  bool isBreak = false;
  final FirestoreUserCreationService _firestoreService =
      FirestoreUserCreationService();
  AudioPlayer audioPlayer = AudioPlayer();

  late CountDownController workingTimerController;
  late CountDownController breakTimerController;

  @override
  void initState() {
    super.initState();
    currentWorkingTime = widget.workingTime > 0 ? widget.workingTime * 60 : 0;
    currentBreakTime = widget.breakTime > 0 ? widget.breakTime * 60 : 0;
    workingTimerController = CountDownController();
    breakTimerController = CountDownController();

    if (currentWorkingTime > 0) {
      workingTimerController.start();
    }

    if (currentBreakTime > 0) {
      breakTimerController.start();
    }
  }

  @override
  void dispose() {
    audioPlayer.pause();
    super.dispose();
  }

  void stopTimer({bool isBreakTimer = false}) {
    if (isBreakTimer) {
      breakTimerController.pause();
    } else {
      workingTimerController.pause();
    }
  }

  void resetTimer() {
    workingTimerController.restart();
    breakTimerController.restart();
    setState(() {});
  }

  void startWorkingTimer({bool isFirstStart = true}) {
    if (isFirstStart) {
      workingTimerController.start();
      backgroundSoundController(true);
      setState(() {});
    } else {
      workingTimerController.resume();
      backgroundSoundController(true);
      setState(() {});
    }
  }

  void startBreakTimer({bool isFirstBreak = true}) {
    if (isFirstBreak) {
      breakTimerController.start();
      backgroundSoundController(false);
      setState(() {});
    } else {
      breakTimerController.resume();
      backgroundSoundController(false);
      setState(() {});
    }
  }

  Future<bool?> showProceedConfirmationDialog(BuildContext context) async {
    // Pause the timers based on the current state
    if (isWorking) {
      stopTimer(isBreakTimer: false);
    } else if (isBreak) {
      stopTimer(isBreakTimer: true);
    }

    if (result == false) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sıfırlama işlemi'),
            content: const Text(
                'Sıfırlama işlemine devam etmek istediğinizden emin misiniz?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    result = true;
                  });
                  // Proceed with the reset
                },
                child: const Text('Devam et'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = false;
                  });
                  Navigator.pop(context); // Cancel the reset
                },
                child: const Text('İptal et'),
              ),
            ],
          );
        },
      );
    }

    if (result == true) {
      // User confirmed reset
      _performReset();
    } else {
      // User canceled reset, resume the timers based on the current state
      if (isWorking) {
        startWorkingTimer(isFirstStart: false);
      } else if (isBreak) {
        startBreakTimer(isFirstBreak: false);
      }
    }

    // Return the result indicating whether to proceed with the reset

    return result;
  }

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
                startWorkingTimer(isFirstStart: false);
              },
              child: const Text('Start Working'),
            ),
          ],
        );
      },
    );
  }

  void _performReset() {
    workingTimerController.reset();
    breakTimerController.reset();
    setState(() {
      isFirstStart = true;
      isFirstBreak = true;
      isWorking = false;
      isBreak = false;
    });
  }

  void setBackgroundSound() async {
    await audioPlayer.setSource(AssetSource(widget.backgroundMusic));
    print("ses işi");
  }

  void backgroundSoundController(bool isPlay) async {
    if (isPlay) {
      print("ses öncesi");
      await audioPlayer.resume();
      print("ses sonrası");
    } else {
      await audioPlayer.pause();
    }
  }

  void _onComplete() {
    if (isWorking) {
      if (isFirstStart) {
        showWellDonePopup(context);
      } else {
        showProceedConfirmationDialog(context);
      }
    } else {
      if (isFirstBreak) {
        showBreakTimeOverDialog();
        startWorkingTimer();
      } else {
        showProceedConfirmationDialog(context);
      }
    }
  }

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
                    MaterialPageRoute(
                        builder: (context) => GoalSelectionScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigationService.instance.navigateToPage(
                                path: NavigationConstants.homePage);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 24,
                          )),
                      Text(
                        widget.goal,
                        style: const TextStyle(
                          //color: Color(0xFF37352F),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.add, size: 24),
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
                      currentWorkingTime > 0
                          ? currentWorkingTime
                          : currentBreakTime,
                      "Çalışma",
                      workingTimerController,
                      isBreakTimer: false,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: buildTimerSection(
                      currentBreakTime > 0
                          ? currentBreakTime
                          : currentWorkingTime,
                      "Ara",
                      breakTimerController,
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
                          onPressed: () {
                            showProceedConfirmationDialog(context);
                          },
                          icon: const Icon(
                            Icons.refresh_sharp,
                            size: 25,
                          ),
                        ),
                      ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 26, 26, 26)
                            : const Color(0xFFE7E7E6),
                        shape: const CircleBorder(),
                        shadows: const [
                          BoxShadow(
                            // color: Color(0xFF37352F),
                            blurRadius: 10,
                            offset: Offset(2, 6),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isWorking) {
                            if (isFirstStart == true) {
                              setBackgroundSound();
                              print("func dışı");

                              isWorking = true;
                              isBreak = false;
                              startWorkingTimer(isFirstStart: true);
                              isFirstStart = false;
                            } else {
                              stopTimer(isBreakTimer: true);
                              isWorking = true;
                              isBreak = false;
                              startWorkingTimer(isFirstStart: false);
                            }
                          } else {
                            if (isFirstBreak == true) {
                              stopTimer(isBreakTimer: false);
                              startBreakTimer(isFirstBreak: true);
                              isWorking = false;
                              isBreak = true;
                              isFirstBreak = false;
                            } else {
                              stopTimer(isBreakTimer: false);
                              isWorking = false;
                              isBreak = true;
                              startBreakTimer(isFirstBreak: false);
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
                          isWorking ? 'Durdur' : 'Başlat',
                          style: const TextStyle(
                            //  color: Color(0xFF37352F),
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
                            if (isMuted) {
                              // Mute audio
                              audioPlayer.setVolume(0.0);
                            } else {
                              // Unmute audio
                              audioPlayer.setVolume(1.0);
                            }
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

  Widget buildTimerSection(
    int time,
    String label,
    CountDownController controller, {
    bool isBreakTimer = false,
  }) {
    final String formattedTime = formatTime(time);
    final double fontSize = isBreakTimer ? 32.0 : 40.0;
    final double circleSize = isBreakTimer ? 150.0 : 250.0;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: ShapeDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 26, 26, 26)
            : const Color(0xFFE7E7E6),
        shape: const CircleBorder(),
        shadows: const [
          BoxShadow(
            // color: Color(0xFF37352F),
            blurRadius: 10,
            offset: Offset(2, 6),
            spreadRadius: 2,
          ),
        ],
      ),
      child: CircularCountDownTimer(
        autoStart: false,
        duration: time,
        controller: controller,
        width: circleSize,
        height: circleSize,
        strokeWidth: 3.0,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 26, 26, 26)
            : const Color(0xFFE7E7E6),
        ringColor: const Color.fromARGB(255, 101, 191, 107),
        backgroundColor: const Color.fromARGB(0, 105, 240, 175),
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        isReverse: true,
        isReverseAnimation: false,
        onComplete: _onComplete,
      ),
    );
  }

  Future<bool> showExitPopup(BuildContext context) async {
    // Pause the timers based on the current state
    if (isWorking) {
      stopTimer(isBreakTimer: false);
    } else if (isBreak) {
      stopTimer(isBreakTimer: true);
    }

    final result = await showDialog<bool>(
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
                          final remainingTime =
                              workingTimerController.getTime().toString();
                          final timeString =
                              remainingTime.replaceAll(RegExp(r":"), "");
                          final elapsedMinutes =
                              widget.workingTime - int.parse(timeString);
                          if (FirebaseAuth.instance.currentUser != null) {
                            _firestoreService.saveWorkingTime(
                              user!.uid,
                              elapsedMinutes,
                            );
                          }
                          NavigationService.instance.navigateToPageRemoveAll(
                              path: NavigationConstants.homePage);
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ),
                          //   ModalRoute.withName('/'), // Remove all routes until reaching the home screen
                          // );
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
                          Navigator.of(context).pop(false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("Hayır",
                            style: TextStyle(color: Colors.black)),
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

    // If the user pressed "Hayır", resume the timer based on the previous state
    if (result == false) {
      if (isWorking) {
        startWorkingTimer(isFirstStart: false);
      } else if (isBreak) {
        startBreakTimer(isFirstBreak: false);
      }
    }

    // Return the result indicating whether to allow the app to be closed
    return result ?? false;
  }

  void showWellDonePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Well Done!'),
          content:
              const Text('Congratulations on completing your working time.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (user != null) {
                  _firestoreService.saveWorkingTime(
                      user!.uid, widget.workingTime);
                }
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
