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
    Color selectColor,
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
          selectColor: selectColor,
        ));
      } else {
        selectedEvents[selectedDate] = [
          Event(
            title: title,
            description: description,
            date: selectedDate,
            eventController: controlEvent,
            timeSelect: timeSelect,
            selectColor: selectColor,
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
