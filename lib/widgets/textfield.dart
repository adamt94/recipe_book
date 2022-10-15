import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField(
      {super.key,
      this.controller,
      this.title,
      this.hintText,
      this.onChanged,
      this.type,
      this.minLines,
      this.index});
  TextEditingController? controller;
  String? title;
  String? hintText;
  Function? onChanged;
  int? index;
  TextInputType? type;
  int? minLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      onSaved: (value) => {},
      onChanged: (val) => {onChanged!(index, val)},
      minLines: minLines,
      maxLines: minLines != null ? 100 : 1,
      decoration: InputDecoration(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
