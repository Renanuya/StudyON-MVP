// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  final String? name;
  final String? surname;
  final String? email;
  final String? password;

  const RegisterRequestModel({this.name, this.surname, this.email, this.password, });

  @override
  List<Object?> get props => [name, surname, email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) => RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
