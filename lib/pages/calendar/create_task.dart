import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'event.dart';

const double _kItemExtent = 32.0;
const List<String> _reminders = <String>[
  'On day of event ',
  '1 day before ',
  '2 days before ',
  '1 week before ',
];

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late Map<DateTime, List<Event>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  bool isRedSelected = false;
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int _selectedIndex = 0;
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  List _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

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
      appBar: AppBar(
        title: const Text(
          'Create Task Page',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        setState(() => time = newTime);
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
            // TextFormField(
            //   decoration: const InputDecoration(
            //     fillColor: Color(0xffE8E8E7),
            //     border: OutlineInputBorder(),
            //     filled: true,
            //     labelText: 'Tarih ve Saat secin',
            //     labelStyle: TextStyle(
            //       color: Colors.black,
            //     ),
            //     hintText: 'Ne yapmak istediğinizi yazın...',
            //     hintStyle: TextStyle(
            //       color: Color(0xFFAFAFAC),
            //     ),
            //   ),
            // ),
            changeColor(mHeight, mWidth),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     fillColor: Color(0xffE8E8E7),
            //     filled: true,
            //     labelText: 'Hatirlatici',
            //     labelStyle: TextStyle(
            //       color: Colors.black,
            //     ),
            //     hintText: 'Acilir Menuden Hatirlatici ...',
            //     hintStyle: TextStyle(
            //       color: Color(0xFFAFAFAC),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffE8E8E7),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Hatirlatici Sec: '),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedIndex,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedIndex = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(_reminders.length,
                            (int index) {
                          return Center(child: Text(_reminders[index]));
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _reminders[_selectedIndex],
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(),
                ),
                elevation: 0,
                minimumSize: Size(mWidth, mHeight * 0.06),
              ),
              onPressed: () async {
                if (_eventController.text.isEmpty) {
                  return;
                } else {
                  if (selectedEvents[selectedDay] != null) {
                    selectedEvents[selectedDay]!.add(Event(
                      title: _eventController.text,
                    ));
                  } else {
                    selectedEvents[selectedDay] = [
                      Event(
                        title: _eventController.text,
                      )
                    ];
                  }
                  _eventController.clear();
                  setState(() {});
                  return;
                }
              },
              child: const Text(
                'Kaydet',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ]
              .map((widget) =>
                  Padding(padding: const EdgeInsets.all(20), child: widget))
              .toList(),
        ),
      ),
    );
  }

  Container changeColor(double mHeight, double mWidth) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[300],
      ),
      height: mHeight * 0.05,
      width: mWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColorButton(
            color: Colors.red,
            onPressed: (isSelected) {
              setState(() {
                isRedSelected = isSelected;
              });
            },
          ),
          ColorButton(
            color: Colors.yellow,
            onPressed: (isSelected) {
              setState(() {
                isRedSelected = isSelected;
              });
            },
          ),
          ColorButton(
            color: Colors.blue,
            onPressed: (isSelected) {
              setState(() {
                isRedSelected = isSelected;
              });
            },
          ),
          ColorButton(
            color: Colors.green,
            onPressed: (isSelected) {
              setState(() {
                isRedSelected = isSelected;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ColorButton extends StatefulWidget {
  final Color color;

  final Function onPressed;

  const ColorButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ColorButtonState createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed(isSelected);
      },
      child: Stack(
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: ShapeDecoration(
              color: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (isSelected)
            const Align(
              child: Icon(
                Icons.check_circle,
                color: Colors.black,
                size: 16,
              ),
            )
        ],
      ),
    );
  }
}

class DatePickerItem extends StatelessWidget {
  const DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffE8E8E7),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
