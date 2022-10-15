import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/screens/Create.dart';
import 'package:recipe_book/screens/Recipes.dart';
import 'package:recipe_book/util/resource.dart';

import 'models/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
              headline1: TextStyle(color: Colors.black, fontSize: 40),
              headline2: TextStyle(color: Colors.black, fontSize: 35),
              headline3: TextStyle(color: Colors.black, fontSize: 30),
              headline4: TextStyle(color: Colors.black, fontSize: 25),
              headline5: TextStyle(color: Colors.black, fontSize: 20)),
          // Brightness.dark/light is estimated based on the default shade for the color
          // This also sets the bool primaryIsDark
          // primaryColorBrightness = estimateBrightnessForColor(primarySwatch);
          // This generates the modern simplified set of theme colors flutter recommends
          // using when theming Widgets based on the theme. Set it manually if you need
          // more control over individual colors
          // colorScheme = ColorScheme.fromSwatch(
          //       primarySwatch: primarySwatch, // as above
          //       primaryColorDark: primaryColorDark, // as above
          //       accentColor: accentColor, // as above
          //       cardColor: cardColor, // default based on theme brightness, can be set manually
          //       backgroundColor: backgroundColor, // as above
          //       errorColor: errorColor, // default (Colors.red[700]), can be set manually
          //       brightness: brightness, // default (Brightness.light), can be set manually
          //     );
          backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          primarySwatch: Colors.indigo),
      home: const MyHomePage(title: 'Recipe Book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Recipe> _recipes = [];
  late ScrollController scrollController;

  void getRecipes() {
    Webservice().load(Recipe.getAll()).then((value) => setState(() {
          print(value);
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
