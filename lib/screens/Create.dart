import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/util/resource.dart';
import 'package:recipe_book/widgets/ImageCapture.dart';
import 'package:recipe_book/widgets/textfield.dart';

import '../models/ingrediant.dart';

class Create extends StatefulWidget {
  String? title;
  String? instructions;
  String? duration;
  List<Ingrediant>? ingrediantsD;
  String? imageurl;
  List<String>? groupNamesD;

  Create(
      {Key? key,
      this.title,
      this.instructions,
      this.duration,
      this.ingrediantsD,
      this.groupNamesD,
      this.imageurl = ''})
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
  List<String> groupNames = [''];
  String imagename = '';
  Uint8List imagesrc = Uint8List(0);
  XFile? xfile;
  String dropdownValue = '';

  @override
  void initState() {
    if (widget.ingrediantsD != null) {
      ingrediants = [...widget.ingrediantsD!];
    }
    if (widget.groupNamesD != null && widget.groupNamesD!.isNotEmpty) {
      groupNames = [...widget.groupNamesD!];
      dropdownValue = groupNames.first;
    }

    titleController.text = widget.title ?? '';
    intructionsController.text = widget.instructions ?? '';
    durationController.text = widget.duration ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onUpdate(int index, String val) async {
      setState(() {
        ingrediants[index] = Ingrediant(name: val);
      });
    }

    _row(int index, Ingrediant ingrediant) {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: customTextField(
                  hintText: 'ingrediant',
                  lrPadding: 5,
                  initValue: ingrediant.name,
                  index: index,
                  onChanged: (i, val) {
                    onUpdate(i, val);
                  },
                )),
          ),
          SizedBox(
            width: 80,
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: customTextField(
                  validator: false,
                  hintText: 'amount',
                  lrPadding: 5,
                  initValue: ingrediant.amount,
                  index: index,
                  onChanged: (i, val) {
                    if (i < ingrediants.length) {
                      ingrediants[i].setAmount(val);
                    }
                  },
                )),
          ),
          SizedBox(
            width: 150,
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: customTextField(
                  validator: false,
                  hintText: 'unit',
                  lrPadding: 5,
                  initValue: ingrediant.unit,
                  index: index,
                  onChanged: (i, val) {
                    if (i < ingrediants.length) {
                      ingrediants[i].setUnit(val);
                    }
                  },
                )),
          ),
          if (groupNames.isNotEmpty)
            IntrinsicWidth(
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: DropdownButton<String>(
                      value: ingrediants[index].groupName != null
                          ? ingrediants[index].groupName!.toLowerCase()
                          : null,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          ingrediants[index].setGroupName(value!);
                        });
                      },
                      items: groupNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toLowerCase(),
                          child: Text(value),
                        );
                      }).toList(),
                    ))),
        ],
      );
    }

    void setImageSrc(Uint8List src) {
      setState(() {
        imagesrc = src;
      });
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
                              style:
                                  Theme.of(context).textTheme.headlineLarge))),
                  ImageCapture(
                    setImageValue: setImageSrc,
                    imageurl: widget.imageurl,
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: titleController,
                    title: 'Title',
                    hintText: 'Give your recipe a name',
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    type: TextInputType.multiline,
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
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text("Add Ingrediants",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text('+ Ingrediant'),
                        onPressed: () {
                          setState(() {
                            ingrediants = [
                              ...ingrediants,
                              Ingrediant(name: '')
                            ];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupNames.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: customTextField(
                              hintText: 'title',
                              initValue: groupNames[index],
                              onChanged: (i, val) {
                                setState(() {
                                  groupNames[index] = val.toString();
                                });
                              },
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    child: const Text('+ Group Name'),
                    onPressed: () {
                      setState(() {
                        groupNames = [...groupNames, ''];
                      });
                    },
                  ),
                  const SizedBox(height: 25),
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
                                ingrediants: ingrediants,
                                ingrediantGroupNames: groupNames);
                            Recipe.addRecipe(createRecipe);
                            final signedurl = await Webservice.getSignurl(
                                titleController.text);

                            if (imagesrc.isNotEmpty) {
                              Webservice.upload(
                                  imagesrc, 'image.jpeg', signedurl);
                            }

                            // ignore: use_build_context_synchronously
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
