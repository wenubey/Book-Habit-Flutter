import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class SortScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SortScreenButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style,
        child: const Text(
          'Clear sorting',
          style: textButtonTextStyle,
        ),
      ),
    );
  }
}
