import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/image_decorations.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double containerSize;
  final String assetUrl;
  const CustomContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    required this.containerSize,
    required this.assetUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageDecoration(
      assetUrl: assetUrl,
      opacity: 1,
      child: Center(
        child: Container(
          height: height * containerSize,
          margin: const EdgeInsets.all(25),
          padding: EdgeInsets.all(width * 0.01),
          decoration: paperImageDecoration(),
          child: Container(
            height: height * 0.55,
            margin: const EdgeInsets.all(24.0),
            decoration: customBoxDecoration,
            child: child,
          ),
        ),
      ),
    );
  }
}
