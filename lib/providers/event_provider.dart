import 'package:flutter/material.dart';
import 'package:thinktank/pages/calendar/event.dart';

class EventProvider extends ChangeNotifier {
  Map<DateTime, List<Event>> selectedEvents = {};

  void addEvent(
    String title,
    String description,
    DateTime selectedDate,
    bool controlEvent,
    DateTime timeSelect,
  ) {
    if (title.isEmpty) {
      return;
    } else {
      if (selectedEvents[selectedDate] != null) {
        selectedEvents[selectedDate]!.add(Event(
          title: title,
          description: description,
          date: selectedDate,
          eventController: controlEvent,
          timeSelect: timeSelect,
        ));
      } else {
        selectedEvents[selectedDate] = [
          Event(
            title: title,
            description: description,
            date: selectedDate,
            eventController: controlEvent,
            timeSelect: timeSelect,
          )
        ];
      }
      notifyListeners();
      return;
    }
  }

  List<Event> getEventsByDate(DateTime date) {
    if (selectedEvents.containsKey(date)) {
      return selectedEvents[date]!;
    } else {
      return [];
    }
  }
}
