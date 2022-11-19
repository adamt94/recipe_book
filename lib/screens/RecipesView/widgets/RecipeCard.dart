import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/screens/details/details.dart';

import '../../../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard(
      {Key? key,
      required this.duration,
      required this.title,
      required this.image,
      required this.child})
      : super(key: key);

  String duration;
  String title;
  String image;
  Widget child;
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: screenSize(context).width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 1))
          ]),
      child: OpenContainer(
        closedElevation: 0,
        middleColor: Colors.white,
        closedColor: Colors.transparent,
        closedBuilder: (context, action) => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  height: 150,
                  width: screenSize(context).width * 0.5,
                  fit: BoxFit.cover,
                  image: Image.network(image).image),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        duration,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        openBuilder: (BuildContext context,
            void Function({Object? returnValue}) action) {
          return child;
        },
      ),
    );
  }
}
