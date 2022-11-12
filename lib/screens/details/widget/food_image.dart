import 'package:flutter/material.dart';

import '../../../models/recipe.dart';

class FoodImg extends StatelessWidget {
  final Recipe? recipe;

  FoodImg({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.all(15),
                width: 220,
                height: 220,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(-1, 10),
                    blurRadius: 10,
                  )
                ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      recipe!.image!,
                      fit: BoxFit.cover,
                    ))),
          )
        ],
      ),
    );
  }
}
