import 'package:book_habits/utils/book_args.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.currentSliderValue,
    required this.screenArgument,
    required this.onChanged,
  }) : super(key: key);

  final double currentSliderValue;
  final BookArgument screenArgument;
  final Function(double?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Slider(
      thumbColor: brickOrange,
      activeColor: whiteGrey,
      inactiveColor: warmBrown,
      value: currentSliderValue,
      max: screenArgument.book.pageCount.toDouble(),
      divisions: screenArgument.book.pageCount,
      label: currentSliderValue.round().toString(),
      onChanged: onChanged,
    );
  }
}
