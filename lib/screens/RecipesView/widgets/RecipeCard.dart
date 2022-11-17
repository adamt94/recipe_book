import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard(
      {Key? key,
      required this.duration,
      required this.title,
      required this.image})
      : super(key: key);

  String duration;
  String title;
  String image;
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              borderRadius: BorderRadius.circular(15),
              child: Image(
                  height: 110,
                  width: screenSize(context).width * 0.4,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                      const Icon(Icons.location_on, color: Colors.black45),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        duration,
                        style: const TextStyle(color: Colors.black45),
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
          return Text('testing');
        },
      ),
    );
  }
}
