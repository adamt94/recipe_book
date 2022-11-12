import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../models/recipe.dart';

class InstructionsText extends StatelessWidget {
  final Recipe? recipe;

  const InstructionsText({super.key, this.recipe});

  @override
  Widget build(BuildContext context) {
    return  MarkdownBody(
            styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                h2: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                h3: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                h4: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                h5: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                h6: TextStyle(
                    color: Theme.of(context)
                        .primaryColor)),
            data: recipe!.instructions ?? '',
      );
  }
}
