import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/repository/wishlist_repository.dart';
import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomEditWishlistRow extends StatelessWidget {
  const CustomEditWishlistRow({
    Key? key,
    required this.repository,
    required this.oldWishlist,
    required this.bookNameController,
    required this.authorNameController,
  }) : super(key: key);

  final WishlistRepository repository;
  final Wishlist oldWishlist;
  final TextEditingController bookNameController;
  final TextEditingController authorNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            repository.editItem(
              oldWishlist,
              bookNameController.text,
              authorNameController.text,
            );
            Navigator.pop(context);
          },
          child: const Text(
            'Edit',
            style: textButtonTextStyle,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AddBookScreen.id,
              arguments: oldWishlist,
            );
          },
          child: const Text(
            'Move to book list',
            style: textButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
