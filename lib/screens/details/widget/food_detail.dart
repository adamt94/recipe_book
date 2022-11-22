import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../models/recipe.dart';
import 'food_qunaity.dart';

class FoodDetail extends StatelessWidget {
  final Recipe? recipe;
  final Widget? widget;
  final String? title;
  const FoodDetail({super.key, this.recipe, this.widget, this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        child: Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Column(
              children: [
                Text(
                  recipe!.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconText(
                      Icons.access_time_outlined,
                      null,
                      recipe!.duration.toString()!,
                    ),
                    _buildIconText(
                      Icons.star_outlined,
                      null,
                      recipe!.duration!.toString(),
                    ),
                    _buildIconText(
                      Icons.local_fire_department_outlined,
                      Colors.red,
                      recipe!.duration.toString()!,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 59,
                ),
                Row(
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(child: widget),
                const SizedBox(height: 20),
              ],
            )));
  }

  _buildIconText(IconData icon, Color? color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color ?? null,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
