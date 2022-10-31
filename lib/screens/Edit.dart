import 'package:flutter/material.dart';
import 'package:recipe_book/models/ingrediant.dart';
import 'package:recipe_book/screens/Create.dart';

import '../models/recipe.dart';

class Edit extends StatelessWidget {
  Edit({super.key, required this.recipe});

  Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Recipe'),
        ),
        body: Create(
          title: recipe.title,
          instructions: recipe.instructions,
          duration: recipe.duration.toString(),
          ingrediantsD: recipe.ingrediants,
          imageurl: recipe.image,
          groupNamesD: recipe.ingrediantGroupNames,
        ));
  }
}
