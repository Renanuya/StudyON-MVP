import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/pages/timerpage/view/timerscreen.dart';
import 'package:thinktank/pages/timerpage/view_model/view_model_timer.dart';

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String goal = '';
  int workingTime = 0;
  int breakTime = 0;
  String backgroundSound = '';
  int selectedTime = 0; // Add selectedTime variable
  String selectedSound = 'Sound 1'; // Add selectedSound variable

  void _startWorking() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainStopwatchScreen(
          goal: goal,
          workingTime: workingTime,
          breakTime: breakTime,
          backgroundMusic: context
              .watch<TimerPageBackgroundMusicProvider>()
              .getSelectedSound
              .values
              .first,
        ),
      ),
      ModalRoute.withName(
          '/'), // Remove all routes until reaching the home screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Hedefinizi belirleyin ve çalışma deneyiminizi bir üst seviyeye çıkartın.',
                style: TextStyle(
                  color: Color(0xFF37352F),
                  fontSize: 24,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 89),
              buildTextField(
                label: 'Hedefiniz',
                hinttext: 'Lütfen hedefinizi yazın..',
                hintstyle: const TextStyle(
                  color: Color(0xFF717171),
                  fontSize: 15,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                ),
                onChanged: (value) {
                  setState(() {
                    goal = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              buildTimePicker(
                label: 'Çalışmak istediğiniz süre',
                selectedTime: workingTime,
                onChanged: (value) {
                  setState(() {
                    workingTime = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              buildTimePicker(
                selectedTime: breakTime,
                label: 'Mola süresi',
                onChanged: (value) {
                  setState(() {
                    breakTime = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              buildSoundPicker(
                label: 'Arka plan sesi',
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      workingTime != 0 &&
                      breakTime != 0) {
                    _startWorking();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hedefinizi , çalışma ve mola sürenizi '
                            'belirleyin.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE7E7E6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFA4A4A3)),
                  ),
                ),
                child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Çalışmaya başlayın!',
                      style: TextStyle(
                        color: Color(0xFF37352F),
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
    required String hinttext,
    required TextStyle hintstyle,
  }) {
    return Form(
      key: _formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          hintText: hinttext,
          hintStyle: hintstyle,
          border: const OutlineInputBorder(),
          fillColor: const Color(0xFFE7E7E6),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          isDense: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen hedefinizi yazın..';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  Widget buildTimePicker({
    required String label,
    required int selectedTime,
    required ValueChanged<int> onChanged,
  }) {
    void showTimePickerDialog() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const ShapeDecoration(
              color: Color(0xFFE2E2E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
            height: 300,
            child: CupertinoTimerPicker(
              minuteInterval: 5,
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: Duration(minutes: selectedTime),
              onTimerDurationChanged: (Duration newDuration) {
                final int minutes = newDuration.inMinutes;
                onChanged(minutes);
              },
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: showTimePickerDialog,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA4A4A3), width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE7E7E6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF37352F)),
            ),
            const SizedBox(width: 8),
            Builder(
              builder: (BuildContext context) {
                return Text(
                  '$selectedTime dakika',
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF37352F)),
                );
              },
            ),
            const Icon(Icons.arrow_drop_down, color: Color(0xFF37352F)),
          ],
        ),
      ),
    );
  }

  Widget buildSoundPicker({
    required String label,
  }) {
    final List<Map<String, String>> soundOptionsMap = [
      {
        'Arkaplan sesi 1': 'sounds/campfire.m4a',
      },
      {'Arkaplan sesi 2': 'sounds/fragments.m4a'},
      {'Arkaplan sesi 3': 'sounds/insChill.m4a'},
      {'Arkaplan sesi 4': 'sounds/askinolayim.mp3'},
    ];

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 200,
              child: CupertinoPicker(
                onSelectedItemChanged: (index) {
                  context
                      .read<TimerPageBackgroundMusicProvider>()
                      .selectedSoundSet = index;
                },
                itemExtent: 40,
                children: soundOptionsMap.map((sound) {
                  return Text(sound.keys.first);
                }).toList(),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA4A4A3), width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE7E7E6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF37352F)),
            ),
            const SizedBox(width: 8),
            Builder(
              builder: (BuildContext context) {
                return Text(
                  context
                      .watch<TimerPageBackgroundMusicProvider>()
                      .getSelectedSound
                      .keys
                      .first,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF37352F)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
