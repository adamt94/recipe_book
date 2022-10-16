import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/util/resource.dart';
import 'package:recipe_book/widgets/textfield.dart';

import '../models/ingrediant.dart';

class Create extends StatefulWidget {
  String? title;
  String? instructions;
  String? duration;
  List<Ingrediant>? ingrediantsD;

  Create(
      {Key? key,
      this.title,
      this.instructions,
      this.duration,
      this.ingrediantsD})
      : super(key: key);

  @override
  State<Create> createState() => _Create();
}

class _Create extends State<Create> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController intructionsController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  List<Ingrediant> ingrediants = [Ingrediant(name: '')];
  String imagename = '';
  Uint8List imagesrc = Uint8List(0);
  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    if (widget.ingrediantsD != null) {
      ingrediants = widget.ingrediantsD!;
    }
    titleController.text = widget.title ?? '';
    intructionsController.text = widget.instructions ?? '';
    durationController.text = widget.duration ?? '';
    _onSaved(int index, String val) async {}
    _onUpdate(int index, String val) async {
      setState(() {
        ingrediants[index] = Ingrediant(name: val);
      });
    }

    _row(int index, Ingrediant ingrediant) {
      return Row(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: customTextField(
                  hintText: 'ingrediant',
                  initValue: ingrediant.name,
                  index: index,
                  onChanged: (i, val) {
                    _onUpdate(i, val);
                  },
                )),
          ),
        ],
      );
    }

    _getFromCamera() async {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        Uint8List src = await image.readAsBytes();
        setState(() {
          imagename = image.name;
          imagesrc = src;
          xfile = image;
        });
      }
    }

    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Text("Create Recipe",
                              style: Theme.of(context).textTheme.headline1))),
                  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: imagesrc.isEmpty
                          ? BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                            )
                          : BoxDecoration(
                              image: DecorationImage(
                                image: Image.memory(imagesrc).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                      child: TextButton(
                        child: const Text('+ Image'),
                        onPressed: () {
                          _getFromCamera();
                        },
                      )),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: titleController,
                    title: 'Title',
                    hintText: 'Give your recipe a name',
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: intructionsController,
                    hintText: "Give instructions to your recipe",
                    title: "Instructions",
                    minLines: 3,
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: durationController,
                    type: TextInputType.number,
                    title: "Duration",
                    hintText: "mins",
                  ),
                  const SizedBox(height: 40),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("Add Ingrediants",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3)),
                  const SizedBox(height: 10),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ingrediants.length,
                      itemBuilder: (context, index) {
                        return _row(index, ingrediants[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    child: const Text('+ Ingrediant'),
                    onPressed: () {
                      setState(() {
                        ingrediants = [...ingrediants, Ingrediant(name: '')];
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(
                        width: 8,
                        height: 50,
                      ),
                      TextButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            Recipe createRecipe = Recipe(
                                title: titleController.text,
                                instructions: intructionsController.text,
                                duration: int.parse(durationController.text),
                                ingrediants: ingrediants);
                            Recipe.addRecipe(createRecipe);
                            final signedurl = await Webservice.getSignurl(
                                titleController.text);
                            Webservice.upload(
                                imagesrc, 'image.jpeg', signedurl);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saving...')),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
