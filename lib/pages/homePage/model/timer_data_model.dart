// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimerDataModel {
  final int? allTime;
  final int? weekly;
  final int? monthly;
  final int? daily;

  TimerDataModel({this.allTime, this.weekly, this.monthly, this.daily});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allTime': allTime,
      'weekly': weekly,
      'monthly': monthly,
      'daily': daily,
    };
  }

  factory TimerDataModel.fromMap(Map<String, dynamic> map) {
    return TimerDataModel(
      allTime: map['allTime'] != null ? map['allTime'] as int : null,
      weekly: map['weekly'] != null ? map['weekly'] as int : null,
      monthly: map['monthly'] != null ? map['monthly'] as int : null,
      daily: map['daily'] != null ? map['daily'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimerDataModel.fromJson(String source) =>
      TimerDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
