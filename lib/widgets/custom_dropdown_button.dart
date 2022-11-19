import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtton extends StatelessWidget {
  const CustomDropdownButtton({
    Key? key,
    required this.selectedGenre,
    required this.height,
    required this.repository,
    required this.onChanged,
  }) : super(key: key);

  final String selectedGenre;
  final double height;
  final BookRepository repository;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: const TextStyle(
        color: warmBrown,
        fontWeight: FontWeight.bold,
        fontFamily: 'Merienda',
      ),
      elevation: 16,
      underline: Container(),
      dropdownColor: paperColor,
      value: selectedGenre,
      menuMaxHeight: height * 0.8,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      items: repository.getDropDownMenuItems(),
      onChanged: onChanged,
    );
  }
}
