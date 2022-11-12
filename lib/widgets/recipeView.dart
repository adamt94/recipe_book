import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:recipe_book/models/ingrediant.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/screens/Create.dart';
import 'package:recipe_book/screens/Edit.dart';

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

  List<Widget> listIngrediants(BuildContext context) {
    List<Widget> ingradiantsList = [];

    for (var ingrediantGroup in recipe.ingrediantGroupNames!.isEmpty
        ? ['']
        : recipe.ingrediantGroupNames ?? []) {
      ingradiantsList.add(Text(ingrediantGroup,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500)));
      for (var item in recipe.ingrediants ?? []) {
        if (item.groupName.toString().toLowerCase() ==
            ingrediantGroup.toString().toLowerCase()) {
          ingradiantsList.add(
            ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: Text(item.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor)),
                title: Text('${item.amount} ${item.unit}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.7)))),
          );
        }
      }
    }
    for (var item in recipe.ingrediants ?? []) {
      if (item.groupName == '' || item.groupName == null) {
        ingradiantsList.add(
          ListTile(
              dense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: Text(item.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor)),
              title: Text('${item.amount} ${item.unit}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.7)))),
        );
      }
    }

    return ingradiantsList;
  }

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
              title: Text("${recipe.title}"),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Edit(recipe: recipe)),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 26.0,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.more_vert),
                    )),
              ],
            ),
            body: Column(
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
                Expanded(
                    child: Scaffold(
                        appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(250),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(0),
                                child: SafeArea(
                                    child: TabBar(
                                  indicatorColor: Theme.of(context).canvasColor,
                                  tabs: tabs,
                                )))),
                        body: TabBarView(children: [
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
                                    ...listIngrediants(context),
                                  ]),
                            ),
                          ]),
                          ListView(children: [
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      MarkdownBody(
                                        styleSheet: MarkdownStyleSheet(
                                            h1: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            h2: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            h3: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            h4: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            h5: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            h6: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        data: recipe.instructions ?? '',
                                      )
                                    ]))
                          ]),
                        ]))),
              ],
            ),
          );
        }));
  }
}
