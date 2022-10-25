import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/util/resource.dart';
import 'package:recipe_book/widgets/textfield.dart';

import '../models/ingrediant.dart';

class ImageCapture extends StatefulWidget {
  String? imageurl;
  Function setImageValue;

  ImageCapture({Key? key, this.imageurl, required this.setImageValue})
      : super(key: key);

  @override
  State<ImageCapture> createState() => _ImageCapture();
}

class _ImageCapture extends State<ImageCapture> {
  Uint8List imagesrc = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    _getFromCamera() async {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        Uint8List src = await image.readAsBytes();
        setState(() {
          imagesrc = src;
        });
        widget.setImageValue(src);
      }
    }

    Decoration getDefaultImage(bool imagePickersrc, String imageurl) {
      if (imagePickersrc == true) {
        return BoxDecoration(
          image: DecorationImage(
            image: Image.memory(imagesrc).image,
            fit: BoxFit.cover,
          ),
        );
      }
      if (imageurl != '') {
        return BoxDecoration(
          image: DecorationImage(
            image: Image.network(imageurl).image,
            fit: BoxFit.cover,
          ),
        );
      }

      return BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
      );
    }

    return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: getDefaultImage(imagesrc.isNotEmpty, widget.imageurl!),
        child: TextButton(
          child: const Text('+ Image'),
          onPressed: () {
            _getFromCamera();
          },
        ));
  }
}
