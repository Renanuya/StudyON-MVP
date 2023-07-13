// ignore_for_file: public_member_api_docs, sort_constructors_first
class Event {
  final String title;
  final String description;

  Event({
    required this.title,
    required this.description,
  });

  String toString() => this.title;
}
