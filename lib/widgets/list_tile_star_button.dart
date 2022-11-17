import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class ListTileStarButton extends StatelessWidget {
  const ListTileStarButton({
    Key? key,
    required this.onPressed,
    required this.isFavourite,
  }) : super(key: key);
  final VoidCallback onPressed;

  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Icon(
        isFavourite ? Icons.star : Icons.star_outline,
        size: 25,
        color: lightOrange,
      ),
    );
  }
}
