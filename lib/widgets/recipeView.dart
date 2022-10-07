import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_book/models/ingrediant.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeView extends StatelessWidget {
  RecipeView({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  static const List<Tab> tabs = <Tab>[
    Tab(
      icon: Icon(Icons.list),
      child: Text('Ingrediants'),
    ),
    Tab(
      icon: Icon(Icons.menu_book),
      child: Text('Instructions'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        // The Builder widget is used to have a different BuildContext to access
        // closest DefaultTabController.
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              // Your code goes here.
              // To get index of current tab use tabController.index
            }
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text('Recipe'),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  color: Colors.black38,
                  height: 250,
                  child: Image(
                    height: 250,
                    width: double.infinity,
                    image: Image.network(recipe.image ?? '').image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 320,
                    child: Scaffold(
                        appBar: AppBar(
                            bottom: const TabBar(
                          tabs: tabs,
                        )),
                        body: TabBarView(children: [
                          ListView(children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    recipe.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.black54,
                                          fontSize: 30.0,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    recipe.instructions ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.black54,
                                          height: 1.5,
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          ListView(children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Ingrediants',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  for (var item in recipe.ingrediants ??
                                      [
                                        Ingrediant(name: 'no ingrediants found')
                                      ])
                                    ListTile(
                                        leading: Text(item.name,
                                            style:
                                                const TextStyle(fontSize: 15)),
                                        title: Text(
                                            '${item.amount} ${item.unit}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color
                                                    ?.withOpacity(0.6)))),
                                ],
                              ),
                            ),
                          ]),
                        ]))),
              ],
            ),
          );
        }));
  }
}
