import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:thinktank/pages/calendar/color_button.dart';

import 'package:thinktank/pages/calendar/date_picker_item.dart';
import 'package:thinktank/pages/calendar/event.dart';
import 'package:thinktank/providers/event_provider.dart';

const double _kItemExtent = 32.0;
DateTime _timeSelect = DateTime.now();
const List<String> _reminders = <String>[
  'Etkinlik günü',
  'Etkinliketen bir gün önce',
  'Etkinliketen iki gün önce',
  'Etkinliketen bir hafa önce',
];

class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({super.key});

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class ReminderModel extends ChangeNotifier {
  int _selectedIndex = 0;

  final List<String> _reminders = <String>[
    'Etkinlik günü',
    'Etkinliketen bir gün önce',
    'Etkinliketen iki gün önce',
    'Etkinliketen bir hafa önce',
  ];

  int get selectedIndex => _selectedIndex;
  List<String> get reminders => _reminders;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  late Map<DateTime, List<Event>> _selectedEvents;

  StartingDayOfWeek weekStart = StartingDayOfWeek.monday;
  //DateTime time = DateTime(2016, 5, 10, 22, 35);
  //DateTime selectedDate = DateTime.now();
  DateTime time = DateTime.now();
  bool isRedSelected = false;
  String selectedTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime calendarFirstDay = DateTime.utc(2020, 1, 1);
  DateTime calendarLastDay = DateTime.utc(2030, 1, 1);
  bool checkController = false;
  late Color _selectColor;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _firstDay = DateTime.utc(2020, 1, 1);
  DateTime _focusedDate = DateTime.now();
  final DateTime _lastDay = DateTime(DateTime.now().year + 5);
  DateTime _selectedDate = DateTime.now();
  final String _formatDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return _selectedEvents[date] ?? [];
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
    final eventProvider = Provider.of<EventProvider>(context);
    final filteredEvents = eventProvider.getEventsByDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yapılacaklar'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TableCalendar(
                rowHeight: mWidth * 0.1,
                focusedDay: _focusedDate,
                firstDay: _firstDay,
                lastDay: _lastDay,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.green[200],
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),

                startingDayOfWeek: StartingDayOfWeek.monday,
                availableGestures: AvailableGestures.all,
                eventLoader: _getEventsfromDay,
                calendarFormat: _calendarFormat,
                onFormatChanged: (CalendarFormat format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                daysOfWeekVisible: true,

                //Day Changed
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(_selectedDate, date);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDate = focusedDay;
                  });
                },
                // rangeStartDay: selectedDate,
                // rangeEndDay: today,

                // eventLoader: (day) => [],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 43, 43, 43)
                      : const Color(0xFFE7E7E6),
                ),
                height: mHeight * 0.35,
                width: mWidth * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(children: [
                            Row(
                              children: [
                                Text('$_formatDate - Yapılacaklar'),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline_sharp,
                                  ),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                      child: AlertDialog(
                                        title: const Text("Add Event"),
                                        content: Form(
                                          key: GlobalKey<FormState>(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: _titleController,
                                                decoration:
                                                    const InputDecoration(
                                                  //fillColor: Color(0xffE8E8E7),
                                                  border: OutlineInputBorder(),
                                                  filled: true,
                                                  labelText: 'Yapılacaklar',
                                                  labelStyle: TextStyle(
                                                      //color: Colors.black,
                                                      ),
                                                  hintText:
                                                      'Ne yapmak istediğinizi yazın...',
                                                  hintStyle: TextStyle(
                                                      // color: Color(0xFFAFAFAC),
                                                      ),
                                                ),
                                              ),
                                              TextField(
                                                controller:
                                                    _descriptionController,
                                                decoration:
                                                    const InputDecoration(
                                                  // fillColor: Color(0xffE8E8E7),
                                                  border: OutlineInputBorder(),
                                                  filled: true,
                                                  labelText: 'Aciklama',
                                                  labelStyle: TextStyle(
                                                      //  color: Colors.black,
                                                      ),
                                                  hintText:
                                                      'Yapmak istediginiz seyin aciklamasini yazin ...',
                                                  hintStyle: TextStyle(
                                                      // color: Color(0xFFAFAFAC),
                                                      ),
                                                ),
                                              ),

                                              //! aradigin yer burasi
                                              //SelectDateTime(),

                                              const TimeWidget(),

                                              const Cupertio(),
                                              ColorSelector(),
                                            ]
                                                .map((widget) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: widget))
                                                .toList(),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                              child: const Text("Ok"),
                                              onPressed: () async {
                                                //! fab yap
                                                String title =
                                                    _titleController.text;
                                                String description =
                                                    _descriptionController.text;
                                                DateTime selectedDate =
                                                    _selectedDate;
                                                bool controlEvent =
                                                    checkController;
                                                DateTime timeSelect =
                                                    _timeSelect;

                                                EventProvider eventProvider =
                                                    Provider.of<EventProvider>(
                                                        context,
                                                        listen: false);

                                                eventProvider.addEvent(
                                                  title,
                                                  description,
                                                  selectedDate,
                                                  controlEvent,
                                                  timeSelect,
                                                );
                                                setState(() {
                                                  timeSelect = time;
                                                });

                                                _titleController.clear();
                                                _descriptionController.clear();

                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                                'Seçilen Gün: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                          ]),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) {
                            Event event = filteredEvents[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color.fromARGB(255, 26, 26, 26)
                                      : const Color(0xFFE7E7E6),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 0.50,
                                      //  color: Color(0xFF37352F),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(event.title),
                                  // subtitle: Text(event.description),
                                  subtitle: Text(
                                      '${event.timeSelect.hour}:${event.timeSelect.minute}'),

                                  // Text(      '${event.timeSelect.hour}:${event.timeSelect.minute}'),
                                  leading: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          event.eventController =
                                              !event.eventController;
                                        });
                                      },
                                      icon: Icon(
                                        color: const Color.fromARGB(
                                            255, 101, 191, 107),
                                        event.eventController
                                            ? Icons.check_box_outlined
                                            : Icons.check_box_outline_blank,
                                      )),

                                  trailing: IconButton(
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: AlertDialog(
                                            title: Text(event.title),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Text(
                                                      'Aciklama :\n${event.description}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium),
                                                  Text(
                                                      'Etkinlink Saati :\n${event.timeSelect.hour}:${event.timeSelect.minute}')
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // AlertDialog kapatmak için yapılacak işlemler
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Tamam"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    icon: const Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
          //aaaaa
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 33, 33, 33)
              : const Color(0xFFE7E7E6),
          border: Border.all(),
          borderRadius: BorderRadius.circular(5)),
      width: mWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Hatirlatici Sec:',
            style: TextStyle(
              //color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
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

                onSelectedItemChanged: (index) {
                  setState(() => _selectedIndex = index);
                  print(_reminders[index]);
                },
                children: List<Widget>.generate(_reminders.length, (int index) {
                  return Center(child: Text(_reminders[index]));
                }),
              ),
            ),
            child: Text(
              _reminders[_selectedIndex],
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeWidget extends StatefulWidget {
  const TimeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
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
    return DatePickerItem(
      children: <Widget>[
        const Text(
          'Time',
          style: TextStyle(fontSize: 16),
        ),
        CupertinoButton(
          onPressed: () => _showDialog(
            CupertinoDatePicker(
              initialDateTime: _timeSelect,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                //! secilen veri burada

                setState(() {
                  _timeSelect = newTime;
                });
                print(newTime);
              },
            ),
          ),
          child: Text(
            '${_timeSelect.hour}:${_timeSelect.minute}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
