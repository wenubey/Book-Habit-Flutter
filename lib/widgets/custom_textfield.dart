import 'package:book_habits/utils/constants.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: customBorderTextField,
            focusedBorder: customBorderTextField,
          ),
          controller: controller,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
