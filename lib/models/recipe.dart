import 'dart:convert';

import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/models/ingrediant.dart';

import '../util/resource.dart';

class Recipe {
  final String title;
  final String? category;
  final String? tags;
  final int? duration;
  final String? image;
  final List<Ingrediant>? ingrediants;
  final String? instructions;
  final int? servings;
  final List<String>? ingrediantGroupNames;

  Recipe(
      {this.instructions,
      this.servings,
      this.ingrediants,
      this.duration,
      this.category,
      this.tags,
      this.image,
      this.ingrediantGroupNames,
      required this.title});

  factory Recipe.fromJson(Map<String, dynamic> jsondata) {
    return Recipe(
        title: jsondata["id"],
        servings: jsondata['servings'],
        duration: int.parse(jsondata['duration']),
        category: jsondata['category'],
        ingrediantGroupNames: jsondata['ingrediantGroupNames'] == null
            ? []
            : fromStringtoList(jsondata['ingrediantGroupNames']),
        ingrediants: jsondata['ingrediants'] == 'null'
            ? []
            : Ingrediant.fromJsonList(jsondata['ingrediants']),
        instructions: jsondata['instructions'],
        tags: jsondata['tags'],
        image:
            'https://imagesampler-s3uploadbucket-13dxin31bn6xs.s3.eu-west-2.amazonaws.com/${jsondata["id"].replaceAll(' ', '')}.jpg');
  }

  static List<String> fromStringtoList(String jsonstring) {
    final result = json.decode(jsonstring);
    Iterable list = result;

    return list.map((e) => e as String).toList();
  }

  static List<Recipe> fromJsonList(String jsondata) {
    final result = json.decode(jsondata);
    Iterable list = result;
    return list.map((model) => Recipe.fromJson(model)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "tags": tags,
      "duration": duration.toString(),
      "image": image,
      "ingrediants": json.encode(ingrediants),
      "instructions": instructions,
      "servings": servings,
      "ingrediantGroupNames": json.encode(ingrediantGroupNames)
    };
  }

  static Map<String, AttributeValue> toDBValue(Recipe item) {
    Map<String, AttributeValue> dbMap = Map();
    dbMap["name"] = AttributeValue(s: item.title);
    dbMap["recipeData"] = AttributeValue(n: 'test');
    return dbMap;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "title: $title, servings: $servings, duration: $duration: categegory: $category, image: $image, ingrediantGroupNames: $ingrediantGroupNames";
  }

  static Resource<List<Recipe>> getAll() {
    String url =
        "https://hv5ny4x2t0.execute-api.eu-west-2.amazonaws.com/prod/items";
    return Resource(
        url: url,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['Items'];

          return list.map((model) => Recipe.fromJson(model)).toList();
        });
  }

  static void addRecipe(Recipe recipe) {
    String url =
        "https://hv5ny4x2t0.execute-api.eu-west-2.amazonaws.com/prod/items";
    Webservice().put(url, recipe.toJson());
  }
}
