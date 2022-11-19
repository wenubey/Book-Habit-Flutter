import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomSortWidget extends StatelessWidget {
  final List<VoidCallback> listOfTaps;
  final VoidCallback onPressed;
  const CustomSortWidget({
    Key? key,
    required this.listOfTaps,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Sort'),
              content: Form(
                  child: Column(
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
              )),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: onPressed,
                    style: Theme.of(context).textButtonTheme.style,
                    child: const Text(
                      'Clear sorting',
                      style: textButtonTextStyle,
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      child: const Icon(Icons.sort, color: beige),
    );
  }
}
