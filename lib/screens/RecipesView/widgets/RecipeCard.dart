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
      width: screenSize(context).width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: OpenContainer(
        closedElevation: 0,
        closedColor: Colors.transparent,
        closedBuilder: (context, action) => Container(
            color: Theme.of(context).colorScheme.surface,
            child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                elevation: 1,
                color: Theme.of(context).colorScheme.surface,
                shadowColor: Theme.of(context).colorScheme.shadow,
                surfaceTintColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
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
                        )),
                  ]),
                ))),
        openBuilder: (BuildContext context,
            void Function({Object? returnValue}) action) {
          return child;
        },
      ),
    );
  }
}
