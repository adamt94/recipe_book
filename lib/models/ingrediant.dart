import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Ingrediant {
  final String name;
  final String? image;
  final String? unit;
  final String? amount;

  Ingrediant({required this.name, this.image, this.unit, this.amount});

  factory Ingrediant.fromJson(Map<String, dynamic> json) {
    return Ingrediant(
        name: json['name'], unit: json['unit'], amount: json['amount']);
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
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name: $name, image: $image, unit: $unit: amount: $amount";
  }
}
