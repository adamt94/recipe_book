import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/screens/details/details.dart';
import 'package:recipe_book/screens/RecipesView/widgets/RecipeCard.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../models/recipe.dart';

class Recipes extends StatelessWidget {
  Recipes({Key? key, required this.recipes, required this.scrollController})
      : super(key: key);

  List<Recipe> recipes;
  ScrollController scrollController;

  int calculateColumns(context) {
    print(MediaQuery.of(context).size.width);

    if (MediaQuery.of(context).size.width > 2400) {
      return 9;
    }
    if (MediaQuery.of(context).size.width > 2100) {
      return 6;
    }

    if (MediaQuery.of(context).size.width > 1800) {
      return 7;
    }
    if (MediaQuery.of(context).size.width > 1500) {
      return 6;
    }

    if (MediaQuery.of(context).size.width > 1200) {
      return 5;
    }

    if (MediaQuery.of(context).size.width > 900) {
      return 4;
    }
    if (MediaQuery.of(context).size.width > 630) {
      return 3;
    }

    if (MediaQuery.of(context).size.width > 220) {
      return 2;
    }

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
        childAspectRatio: 0.65,
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        physics: const BouncingScrollPhysics(),
        crossAxisCount: calculateColumns(context),
        children: <Widget>[
          for (var item in recipes)
            RecipeCard(
                duration: item.duration.toString(),
                title: item.title,
                image: item.image ?? '',
                child: DetailPage(recipe: item))
        ]);
  }
}
