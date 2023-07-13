// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:thinktank/pages/calendar/calendar_main_page.dart';
import 'package:thinktank/pages/calendar/color_button.dart';
import 'package:thinktank/pages/calendar/date_picker_item.dart';
import 'package:thinktank/pages/calendar/event.dart';

class CreateEventPage extends StatefulWidget {
  final Map<DateTime, List<Event>>? selectedEvents;
  final DateTime selectedDate;
  const CreateEventPage({
    Key? key,
    required this.selectedEvents,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

bool isRedSelected = false;

TextEditingController _eventController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
DateTime time = DateTime.now();

class _CreateEventPageState extends State<CreateEventPage> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Yeni Yapilacak Ekle ',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              controller: _eventController,
              decoration: const InputDecoration(
                fillColor: Color(0xffE8E8E7),
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Yapılacaklar',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Ne yapmak istediğinizi yazın...',
                hintStyle: TextStyle(
                  color: Color(0xFFAFAFAC),
                ),
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                fillColor: Color(0xffE8E8E7),
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Aciklama',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Yapmak istediginiz seyin aciklamasini yazin ...',
                hintStyle: TextStyle(
                  color: Color(0xFFAFAFAC),
                ),
              ),
            ),

            //! aradigin yer burasi
            //SelectDateTime(),
            DatePickerItem(
              children: <Widget>[
                const Text('Time'),
                CupertinoButton(
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: time,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newTime) {
                        //! secilen veri burada

                        setState(() {
                          time = newTime;
                        });
                        print(newTime);
                      },
                    ),
                  ),
                  child: Text(
                    '${time.hour}:${time.minute}',
                    style: const TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
            ColorSelector(),
            const Cupertio(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(mWidth, mHeight * 0.1)),
              onPressed: () {
                String eventTitle = _eventController.text;
                String eventDescription = _descriptionController.text;

                if (eventTitle.isEmpty) {
                  return;
                } else {
                  if (widget.selectedEvents?[widget.selectedDate] != null) {
                    widget.selectedEvents?[widget.selectedDate]!.add(
                      Event(
                        title: eventTitle,
                        description: eventDescription,
                      ),
                    );
                  } else {
                    widget.selectedEvents?[widget.selectedDate] = [
                      Event(
                        title: eventTitle,
                        description: eventDescription,
                      ),
                    ];
                  }
                  _eventController.clear();
                  _descriptionController.clear();

                  Navigator.pop(context);
                  return;
                }
              },
              child: const Text(
                'Kaydet',
              ),
            ),
            SizedBox(
              height: mHeight * 0.01,
            ),
          ]
              .map((widget) =>
                  Padding(padding: const EdgeInsets.all(10), child: widget))
              .toList(),
        ),
      ),
    );
  }

  Container changeColor(double mHeight, double mWidth) {
    Color? selectedColor;

    void selectColor(Color color) {
      setState(() {
        selectedColor = color;
      });
    }

    return Container(
      height: mHeight * 0.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorButton(
                color: Colors.red,
                isSelected: selectedColor == Colors.red,
                onPressed: selectColor,
              ),
              ColorButton(
                color: Colors.blue,
                isSelected: selectedColor == Colors.blue,
                onPressed: selectColor,
              ),
              ColorButton(
                color: Colors.green,
                isSelected: selectedColor == Colors.green,
                onPressed: selectColor,
              ),
              ColorButton(
                color: Colors.yellow,
                isSelected: selectedColor == Colors.yellow,
                onPressed: selectColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
