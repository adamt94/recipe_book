import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/screens/details/widget/food_detail.dart';
import 'package:recipe_book/screens/details/widget/food_image.dart';

import '../../models/recipe.dart';
import '../../widgets/customAppBar.dart';

class DetailPage extends StatelessWidget {
  final Recipe recipe;
  const DetailPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                recipeImage: recipe.image!,
                leftIcon: Icons.arrow_back,
                rightIcon: Icons.favorite_outline,
                leftCallback: () => Navigator.pop(context),
              ),
              FoodImg(
                recipe: recipe,
              ),
              FoodDetail(
                recipe: recipe,
              )
            ],
          ),
        ),
        floatingActionButton: Container(
            width: 100,
            height: 56,
            child: RawMaterialButton(
              onPressed: () {},
              fillColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Text(
                      recipe!.duration!.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
