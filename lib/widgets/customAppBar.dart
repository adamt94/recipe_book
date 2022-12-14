import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final String recipeImage;
  final Function()? leftCallback;
  final Function()? rightCallback;

  const CustomAppBar(
      {Key? key,
      required this.leftIcon,
      required this.rightIcon,
      required this.recipeImage,
      this.leftCallback,
      this.rightCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback!() : null,
            child: _buildIcon(leftIcon, context),
          ),
          GestureDetector(
            onTap: rightCallback != null ? () => rightCallback!() : null,
            child: _buildIcon(rightIcon, context),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface),
      child: Icon(icon),
    );
  }
}
