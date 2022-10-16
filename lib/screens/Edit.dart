import 'package:flutter/material.dart';
import 'package:recipe_book/models/ingrediant.dart';
import 'package:recipe_book/screens/Create.dart';

class Edit extends StatelessWidget {
  Edit(
      {super.key,
      required this.title,
      required this.instructions,
      required this.duration,
      this.ingrediants});

  String title;
  String instructions;
  int duration;
  List<Ingrediant>? ingrediants;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Recipe'),
        ),
        body: Create(
          title: title,
          instructions: instructions,
          duration: duration.toString(),
          ingrediantsD: ingrediants,
        ));
  }
}
