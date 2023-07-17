import 'dart:ui';

class Event {
  String title;
  String description;
  DateTime date;
  DateTime timeSelect;
  bool eventController;
  Color selectColor;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.eventController,
    required this.timeSelect,
    required this.selectColor,
  });
}
