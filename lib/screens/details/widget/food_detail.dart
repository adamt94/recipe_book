import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../models/recipe.dart';
import 'food_qunaity.dart';

class FoodDetail extends StatelessWidget {
  final Recipe? recipe;
  FoodDetail({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Text(
              recipe!.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconText(
                  Icons.access_time_outlined,
                  Colors.blue,
                  recipe!.duration.toString()!,
                ),
                _buildIconText(
                  Icons.star_outlined,
                  Colors.amber,
                  recipe!.duration!.toString(),
                ),
                _buildIconText(
                  Icons.local_fire_department_outlined,
                  Colors.red,
                  recipe!.duration.toString()!,
                ),
              ],
            ),
            SizedBox(
              height: 39,
            ),
            FoodQuantity(recipe: recipe),
            SizedBox(
              height: 39,
            ),
            Row(
              children: [
                Text(
                  'Ingredienta',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          children: [
                            Text(recipe!.ingrediants![index].name),
                          ],
                        ),
                      ),
                  separatorBuilder: (_, index) => SizedBox(
                        width: 15,
                      ),
                  itemCount: recipe!.ingrediants!.length),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              recipe!.instructions!,
              style: TextStyle(fontSize: 16, wordSpacing: 1.2, height: 1.5),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
