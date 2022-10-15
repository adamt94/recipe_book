import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  RecipeCard(
      {Key? key,
      required this.title,
      required this.duration,
      required this.image})
      : super(key: key);

  String title;
  String duration;
  String image;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image(
                  height: 250,
                  width: double.infinity,
                  image: Image.network(image).image,
                  fit: BoxFit.cover,
                ),
              )
            ]),
            Padding(
                padding: const EdgeInsets.fromLTRB(17, 5, 5, 5),
                child: Row(children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                ])),
            Container(
              alignment: Alignment.centerLeft,
              child: ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text(title),
                trailing: Icon(Icons.favorite_outline),
              ),
            ),
          ],
        ));
  }
}
