import 'package:flutter/material.dart';
import 'package:recipe_book/screens/Create.dart';

class Edit extends StatelessWidget {
  Edit(
      {super.key,
      required this.title,
      required this.instructions,
      required this.duration});

  String title;
  String instructions;
  int duration;

  @override
  Widget build(BuildContext context) {
    print(title);
    print(instructions);
    print(duration);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Recipe'),
        ),
        body: Create(
          title: title,
          instructions: instructions,
          duration: duration.toString(),
        ));
  }
}
