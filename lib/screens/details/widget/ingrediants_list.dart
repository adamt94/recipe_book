import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../models/recipe.dart';

class IngrediantsText extends StatelessWidget {
  final Recipe? recipe;
  const IngrediantsText({super.key, this.recipe});

  List<Widget> listIngrediants(BuildContext context) {
    List<Widget> ingradiantsList = [];

    for (var ingrediantGroup in recipe!.ingrediantGroupNames!.isEmpty
        ? ['']
        : recipe!.ingrediantGroupNames ?? []) {
      ingradiantsList.add(Text(ingrediantGroup,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary)));
      for (var item in recipe!.ingrediants ?? []) {
        if (item.groupName.toString().toLowerCase() ==
            ingrediantGroup.toString().toLowerCase()) {
          ingradiantsList.add(
            ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: Text(item.name,
                    style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground)
                        .copyWith(fontWeight: FontWeight.w500)),
                title: Text('${item.amount} ${item.unit}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7)))),
          );
        }
      }
    }
    for (var item in recipe!.ingrediants ?? []) {
      if (item.groupName == '' || item.groupName == null) {
        ingradiantsList.add(
          ListTile(
              dense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: Text(item.name,
                  style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground)
                      .copyWith(fontWeight: FontWeight.w500)),
              title: Text('${item.amount} ${item.unit}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7)))),
        );
      }
    }

    return ingradiantsList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...listIngrediants(context)]);
  }
}
