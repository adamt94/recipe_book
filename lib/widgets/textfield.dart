import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField(
      {super.key,
      this.controller,
      this.title,
      this.hintText,
      this.onChanged,
      this.initValue,
      this.type,
      this.minLines,
      this.lrPadding = 20,
      this.validator = true,
      this.index});
  TextEditingController? controller;
  String? title;
  String? hintText;
  Function? onChanged;
  int? index;
  TextInputType? type;
  int? minLines;
  String? initValue;
  double lrPadding;
  bool validator;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(lrPadding, 0, lrPadding, 0),
        child: TextFormField(
          controller: controller,
          keyboardType: type ?? TextInputType.text,
          onSaved: (value) => {},
          onChanged: (val) => {onChanged!(index, val)},
          minLines: minLines,
          initialValue: initValue,
          maxLines: minLines != null ? 100 : 1,
          decoration: InputDecoration(
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "$hintText",
              fillColor: Colors.white,
              filled: true,
              hoverColor: Colors.white70,
              label: title != null ? Text("$title") : null),
          validator: validator
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }
              : null,
        ));
  }
}
