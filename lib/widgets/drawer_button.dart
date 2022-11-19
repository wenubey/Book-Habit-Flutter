import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_container_with_image.dart';
import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: CustomContainerWithImage(
        assetUrl: 'assets/images/wood.jpg',
        opacity: 1,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: listTileTextStyle,
          ),
        ),
      ),
    );
  }
}
