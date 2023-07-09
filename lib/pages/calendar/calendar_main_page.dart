import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thinktank/pages/calendar/create_task.dart';
import 'package:thinktank/pages/calendar/event.dart';

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
  late Map<DateTime, List<Event>> selectedEvents;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  StartingDayOfWeek weekStart = StartingDayOfWeek.monday;
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime selectedDate = DateTime.now();
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
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar page '),
      ),
      body: Center(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateTaskPage(),
                              ),
                            );
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
                                    title: Text(
                                      event.title,
                                    ),
                                    leading: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.circle)),
                                  ),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                const Time(),
                changeColor(mHeight, mWidth),
                const Cupertio()
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
              ]
                  .map((widget) =>
                      Padding(padding: const EdgeInsets.all(10), child: widget))
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
              ),
            ],
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

/*

showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Yeni Görev Ekle'),
                                      actions: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            fillColor: Color(0xffE8E8E7),
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            labelText: 'Yapılacaklar',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            hintText:
                                                'Ne yapmak istediğinizi yazın...',
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
                                            labelText: 'Yapılacaklar',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            hintText:
                                                'Ne yapmak istediğinizi yazın...',
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
                                                  mode: CupertinoDatePickerMode
                                                      .time,
                                                  use24hFormat: true,
                                                  onDateTimeChanged:
                                                      (DateTime newTime) {
                                                    setState(
                                                        () => time = newTime);
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
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Colors.grey[300],
                                          ),
                                          height: mHeight * 0.05,
                                          width: mWidth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffE8E8E7),
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Text(
                                                'Hatirlatici Sec: ',
                                                style: TextStyle(
                                                  fontSize: 10,
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
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                      initialItem:
                                                          _selectedIndex,
                                                    ),
                                                    // This is called when selected item is changed.
                                                    onSelectedItemChanged:
                                                        (int selectedItem) {
                                                      setState(() {
                                                        _selectedIndex =
                                                            selectedItem;
                                                      });
                                                    },
                                                    children:
                                                        List<Widget>.generate(
                                                            _reminders.length,
                                                            (int index) {
                                                      return Center(
                                                          child: Text(
                                                              _reminders[
                                                                  index]));
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(),
                                            ),
                                            elevation: 0,
                                            minimumSize:
                                                Size(mWidth, mHeight * 0.06),
                                          ),
                                          onPressed: () async {},
                                          child: const Text(
                                            'Kaydet',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ]
                                          .map((widget) => Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: widget))
                                          .toList(),
                                    ))
*/
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

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
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

  DateTime time = DateTime(2016, 5, 10, 22, 35);

  @override
  Widget build(BuildContext context) {
    return DatePickerItem(
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
    );
  }
}
