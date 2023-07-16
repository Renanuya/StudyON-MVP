// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RankDataListModel {
  final String? name;
  final String? surname;
  final int? allTime;
  final int? weekly;
  final int? monthly;
  final int? daily;
  final String? uid;

  RankDataListModel(
      {this.name,
      this.surname,
      this.allTime,
      this.weekly,
      this.monthly,
      this.daily,
      this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'allTime': allTime,
      'weekly': weekly,
      'monthly': monthly,
      'daily': daily,
    };
  }

  factory RankDataListModel.fromMap(Map<String, dynamic> map) {
    return RankDataListModel(
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      allTime: map['allTime'] != null ? map['allTime'] as int : null,
      weekly: map['weekly'] != null ? map['weekly'] as int : null,
      monthly: map['monthly'] != null ? map['monthly'] as int : null,
      daily: map['daily'] != null ? map['daily'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RankDataListModel.fromJson(String source) =>
      RankDataListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
