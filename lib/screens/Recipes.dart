import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/widgets/recipeView.dart';
import 'package:recipe_book/screens/OpenContainerTransformDemo.dart';
import 'package:recipe_book/widgets/recipeCard.dart';
import '../models/recipe.dart';

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.recipe,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, Function _) {
        return RecipeView(
          recipe: recipe,
        );
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class Recipes extends StatelessWidget {
  Recipes({Key? key, required this.recipes}) : super(key: key);

  List<Recipe> recipes;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      for (var item in recipes)
        _OpenContainerWrapper(
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return InkWell(
                onTap: openContainer,
                child: RecipeCard(
                  duration: item.duration.toString(),
                  title: item.title,
                  image: item.image ?? '',
                ));
          },
          onClosed: (data) {},
          recipe: item,
        )
    ]));
  }
}
