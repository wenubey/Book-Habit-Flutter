import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFieldList extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  const CustomTextFieldList({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.controller3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your book name',
            //hintStyle: const TextStyle(color: Colors.white),
            enabledBorder: customBorderTextField,
            focusedBorder: customBorderTextField,
          ),
          controller: controller1,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter book\'s author name',
            enabledBorder: customBorderTextField,
            focusedBorder: customBorderTextField,
          ),
          controller: controller2,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter page count',
            //hintStyle: const TextStyle(color: Colors.white),
            enabledBorder: customBorderTextField,
            focusedBorder: customBorderTextField,
          ),
          controller: controller3,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
