import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thinktank/pages/calendar/color_button.dart';

import 'package:thinktank/pages/calendar/date_picker_item.dart';
import 'package:thinktank/pages/calendar/date_time.dart';
import 'package:thinktank/pages/calendar/event.dart';
import 'package:thinktank/pages/calendar/time_model.dart';

const double _kItemExtent = 32.0;
const List<String> _reminders = <String>[
  'On day of event ',
  '1 day before ',
  '2 days before ',
  '1 week before ',
];

class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({super.key});

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class ReminderModel extends ChangeNotifier {
  int _selectedIndex = 0;

  List<String> _reminders = <String>[
    'On day of event ',
    '1 day before ',
    '2 days before ',
    '1 week before ',
  ];

  int get selectedIndex => _selectedIndex;
  List<String> get reminders => _reminders;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  void _onTimeChanged(DateTime newTime) {
    setState(() {
      selectedTime = newTime as String;
    });
  }

  late Map<DateTime, List<Event>> selectedEvents;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  StartingDayOfWeek weekStart = StartingDayOfWeek.monday;
  //DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime selectedDate = DateTime.now();
  DateTime time = DateTime.now();
  bool isRedSelected = false;
  String selectedTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String formatDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime calendarFirstDay = DateTime.utc(2020, 1, 1);
  DateTime calendarLastDay = DateTime.utc(2030, 1, 1);
  int _selectedIndex = 0;

  void _onSelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
    });
  }

  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
    TimeModel timeModel = Provider.of<TimeModel>(context);
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar page '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TableCalendar(
                focusedDay: selectedDay,
                firstDay: calendarFirstDay,
                lastDay: calendarLastDay,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                ),
                calendarStyle: const CalendarStyle(),

                startingDayOfWeek: weekStart,
                availableGestures: AvailableGestures.all,
                eventLoader: _getEventsfromDay,
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                daysOfWeekVisible: true,

                //Day Changed
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                  print(focusedDay);
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },

                // rangeStartDay: selectedDate,
                // rangeEndDay: today,

                // eventLoader: (day) => [],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                height: mHeight * 0.3,
                width: mWidth * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(children: [
                            Text('$formatDate - Yapılacaklar'),
                            Text(
                              'Seçilen Gün: ' +
                                  DateFormat('dd/MM/yyyy').format(selectedDay),
                            ),
                          ]),
                          IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const CreateTaskPage(),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_sharp,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: _getEventsfromDay(selectedDay)
                              .map(
                                (Event event) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 0.50,
                                          color: Color(0xFF37352F),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: ListTile(
                                        title: Column(
                                          children: [
                                            Text(
                                              event.title,
                                            ),
                                          ],
                                        ),
                                        leading: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.check_box)),
                                        trailing: IconButton(
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SingleChildScrollView(
                                                child: AlertDialog(
                                                  title: Text(event.title),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: ListBody(
                                                              children: [
                                                        Text(event.description),
                                                        Text(timeModel.time.hour
                                                                .toString() +
                                                            ':' +
                                                            timeModel
                                                                .time.minute
                                                                .toString())
                                                      ])),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        // AlertDialog kapatmak için yapılacak işlemler
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Tamam"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          icon: const Icon(
                                              Icons.arrow_forward_ios),
                                        )),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: AlertDialog(
              title: const Text("Add Event"),
              content: Column(
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
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xffE8E8E7),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Aciklama',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintText:
                          'Yapmak istediginiz seyin aciklamasini yazin ...',
                      hintStyle: TextStyle(
                        color: Color(0xFFAFAFAC),
                      ),
                    ),
                  ),

                  //! aradigin yer burasi
                  SelectDateTime(),
                  // DatePickerItem(
                  //   children: <Widget>[
                  //     const Text('Time'),
                  //     CupertinoButton(
                  //       onPressed: () => _showDialog(
                  //         CupertinoDatePicker(
                  //           initialDateTime: time,
                  //           mode: CupertinoDatePickerMode.time,
                  //           use24hFormat: true,
                  //           onDateTimeChanged: (DateTime newTime) {
                  //             //! secilen veri burada

                  //             setState(() {
                  //               time = newTime;
                  //             });
                  //             print(newTime);
                  //           },
                  //         ),
                  //       ),
                  //       child: Text(
                  //         '${time.hour}:${time.minute}',
                  //         style: const TextStyle(
                  //           fontSize: 22.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  changeColor(mHeight, mWidth),
                  const Cupertio()
                ]
                    .map((widget) => Padding(
                        padding: const EdgeInsets.all(10), child: widget))
                    .toList(),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () async {
                    if (_eventController.text.isEmpty) {
                      return;
                    } else {
                      if (selectedEvents[selectedDay] != null) {
                        selectedEvents[selectedDay]!.add(Event(
                          title: _eventController.text,
                          description: _descriptionController.text,
                        ));
                      } else {
                        selectedEvents[selectedDay] = [
                          Event(
                            title: _eventController.text,
                            description: _descriptionController.text,
                          )
                        ];
                      }
                      _eventController.clear();
                      _descriptionController.clear();

                      setState(() {});
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
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
      child: Column(
        children: [
          Row(
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
            ],
          ),
          SizedBox(
            height: mHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
        ],
      ),
    );
  }
}

class Cupertio extends StatefulWidget {
  const Cupertio({super.key});

  @override
  State<Cupertio> createState() => _CupertioState();
}

class _CupertioState extends State<Cupertio> {
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double mWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffE8E8E7),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      width: mWidth * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Hatirlatici Sec:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
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
                onSelectedItemChanged: (index) {
                  setState(() => _selectedIndex = index);
                  print(_reminders[index]);
                },
                children: List<Widget>.generate(_reminders.length, (int index) {
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
    );
  }
}
