import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/screens/Create.dart';
import 'package:recipe_book/screens/RecipesView/Recipes.dart';
import 'package:recipe_book/util/resource.dart';

import 'models/recipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => App();
}

class App extends State<MyApp> {
  late bool lightTheme;

  @override
  void initState() {
    super.initState();
    lightTheme = true;
  }

  void setTheme() {
    lightTheme = !lightTheme;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe book',
      themeMode: lightTheme == true ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light, seedColor: Colors.indigo),
          iconTheme: const IconThemeData(color: Colors.indigo),
          backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          primarySwatch: Colors.indigo),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: Colors.indigo),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 140, 156, 243)),
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Recipe Book', themeToggle: setTheme),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.themeToggle});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final Function themeToggle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Recipe> _recipes = [];
  late ScrollController scrollController;

  void getRecipes() {
    Webservice().load(Recipe.getAll()).then((value) => setState(() {
          _recipes = value;
        }));
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('testdata/recipes.json');

    final data = Recipe.fromJsonList(response);
    setState(() {
      _recipes = data;
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _selectedIndex++;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    final screens = [
      Recipes(
        recipes: _recipes,
        scrollController: scrollController,
      ),
      Create()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.sunny,
                  color: Theme.of(context).colorScheme.inverseSurface),
              onPressed: () {
                widget.themeToggle();
              })
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
