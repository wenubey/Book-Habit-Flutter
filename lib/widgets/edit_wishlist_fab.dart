import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/repository/wishlist_repository.dart';
import 'package:book_habits/screens/wishlist_screen.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class EditWishlistFAB extends StatelessWidget {
  const EditWishlistFAB({
    Key? key,
    required this.repository,
    required this.oldWishlist,
  }) : super(key: key);

  final WishlistRepository repository;
  final Wishlist oldWishlist;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: brickOrange,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Operation'),
              content: const Text(
                deleteConfirmationWishText,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    repository.deleteItem(oldWishlist.id);
                    Navigator.of(context).pushNamed(WishlistScreen.id);
                  },
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
          },
        );
      },
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
