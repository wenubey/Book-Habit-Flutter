import 'package:book_habits/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomGestureList extends StatelessWidget {
  final List<VoidCallback> listOfTaps;
  const CustomGestureList({
    Key? key,
    required this.listOfTaps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: listOfTaps[0],
          child: const Text('Title'),
        ),
        const CustomDivider(),
        GestureDetector(
          onTap: listOfTaps[1],
          child: const Text('Author'),
        ),
        const CustomDivider(),
        GestureDetector(
          onTap: listOfTaps[2],
          child: const Text('Current Page'),
        ),
        const CustomDivider(),
        GestureDetector(
          onTap: listOfTaps[3],
          child: const Text('Finished Books First'),
        ),
        const CustomDivider(),
        GestureDetector(
          onTap: listOfTaps[4],
          child: const Text('Genre'),
        ),
      ],
    );
  }
}
