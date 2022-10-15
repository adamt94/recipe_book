import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/util/resource.dart';

import '../models/ingrediant.dart';

class Create extends StatefulWidget {
  String? title;
  String? instructions;
  String? duration;
  List<Ingrediant>? ingrediantsD;

  Create({Key? key, this.title, this.instructions, this.duration})
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
    titleController.text = widget.title!;
    intructionsController.text = widget.instructions!;
    durationController.text = widget.duration!;
    _onSaved(int index, String val) async {}
    _onUpdate(int index, String val) async {
      setState(() {
        ingrediants[index] = Ingrediant(name: val);
      });
    }

    _row(int index) {
      return Row(
        children: [
          Text('${index + 1}'),
          const SizedBox(width: 30),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(hintText: 'ingrediant'),
              onChanged: (val) {
                _onUpdate(index, val);
              },
            ),
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
          Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Text("Create Recipe",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium))),
                    Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: imagesrc.isEmpty
                            ? null
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
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      onSaved: (value) => {},
                      // {onClickAction(double.tryParse(value!))},
                      decoration: const InputDecoration(
                          hintText: "Give your recipe a name",
                          label: Text("Title")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: intructionsController,
                      keyboardType: TextInputType.text,
                      onSaved: (value) => {},
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Give instructions to your recipe",
                        label: const Text("Intructions"),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).canvasColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text("Duration",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle1)),
                    TextFormField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'mins'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        final number = num.tryParse(value);
                        if (number == null) {
                          return 'enter a number you fucking idiot';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text("Add Ingrediants",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle1)),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ingrediants.length,
                        itemBuilder: (context, index) {
                          return _row(index);
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
          ),
        ],
      ),
    ));
  }
}
