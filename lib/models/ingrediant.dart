import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Ingrediant {
  final String name;
  final String? image;
  String? unit;
  String? amount;
  String? groupName;

  Ingrediant(
      {required this.name, this.image, this.unit, this.amount, this.groupName});

  factory Ingrediant.fromJson(Map<String, dynamic> json) {
    return Ingrediant(
        name: json['name'],
        unit: json['unit'],
        amount: json['amount'],
        groupName: json['groupName']);
  }

  void setUnit(String val) {
    unit = val;
  }

  void setAmount(String val) {
    amount = val;
  }

  static List<Ingrediant> fromJsonList(String jsondata) {
    final result = json.decode(jsondata);
    Iterable list = result;
    return list.map((model) => Ingrediant.fromJson(model)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "unit": unit,
      "amount": amount,
      "image": image,
      "groupName": groupName
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name: $name, image: $image, unit: $unit: amount: $amount, groupName: $groupName";
  }
}
