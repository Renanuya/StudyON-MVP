import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thinktank/pages/calendar/create_task.dart';

class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({super.key});

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  DateTime today = DateTime.now();
  String formatDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime calendarFirstDay = DateTime.utc(2020, 1, 1);
  DateTime calendarLastDay = DateTime.utc(2030, 1, 1);
  void _onSelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
              focusedDay: today,
              firstDay: calendarFirstDay,
              lastDay: calendarLastDay,
              calendarStyle: const CalendarStyle(),
              calendarFormat: CalendarFormat.month,
              onDaySelected: _onSelected,
              selectedDayPredicate: (day) => isSameDay(day, today),
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
                          Text('$formatDate - Yapilacaklar'),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateTaskPage()),
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_sharp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
              width: 280,
              height: 40,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 280,
                      height: 40,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 280,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Color(0xFF37352F)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Flutter MVVM çalış',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 8,
                            child: Container(
                              width: 25,
                              height: 25,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: const Stack(children: []),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
