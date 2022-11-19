import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomContainerWithImage extends StatelessWidget {
  final String assetUrl;
  final double opacity;
  final Widget child;
  const CustomContainerWithImage({
    Key? key,
    required this.assetUrl,
    required this.opacity,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetUrl),
          fit: BoxFit.cover,
          opacity: opacity,
        ),
      ),
      child: child,
    );
  }
}

BoxDecoration paperImageDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/paper.jpg'),
      fit: BoxFit.fill,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 5,
        color: shadowColor,
      ),
    ],
  );
}
