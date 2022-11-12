import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/screens/details/widget/food_detail.dart';
import 'package:recipe_book/screens/details/widget/food_image.dart';
import 'package:recipe_book/screens/details/widget/ingrediants_list.dart';
import 'package:recipe_book/screens/details/widget/instructions_list.dart';

import '../../models/recipe.dart';
import '../../widgets/customAppBar.dart';


class DetailPage extends StatefulWidget {

  final Recipe recipe;
  const DetailPage({super.key, required this.recipe});

  @override
  State<DetailPage> createState() => DetailPageState();
}
class DetailPageState extends State<DetailPage> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getFoodDetailsWidget(Recipe recipe,String title, Widget widget){
    
            return FoodDetail(
                recipe: recipe,
                title: title,
                widget: widget,
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Instructions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Instructions',
          )
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                recipeImage: widget.recipe.image!,
                leftIcon: Icons.arrow_back,
                rightIcon: Icons.favorite_outline,
                leftCallback: () => Navigator.pop(context),
              ),
              FoodImg(
                recipe: widget.recipe,
              ),
              getFoodDetailsWidget(widget.recipe,_selectedIndex == 0? 'Ingrediants': 'Instructions',_selectedIndex == 0?IngrediantsText(recipe: widget.recipe): InstructionsText(recipe : widget.recipe) )
            ],
          ),
        ));
  }
}
