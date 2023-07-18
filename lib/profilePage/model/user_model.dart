// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? surname;
  final String? ppUrl;
  const UserModel({
    this.name,
    this.surname,
    this.ppUrl,
  });

  UserModel copyWith({
    String? name,
    String? surname,
    String? ppUrl,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      ppUrl: ppUrl ?? this.ppUrl,
    );
  }

  @override
  List<Object?> get props => [name, surname, ppUrl];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'ppUrl': ppUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      ppUrl: map['ppUrl'] != null ? map['ppUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}