import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.onPressed,
    required this.contentText,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String contentText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
