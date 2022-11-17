import 'package:book_habits/repository/wishlist_repository.dart';
import 'package:book_habits/screens/wishlist_screen.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_container_widget.dart';

import 'package:flutter/material.dart';

class AddWishlistScreen extends StatefulWidget {
  static const id = 'add_wishlist_screen';
  const AddWishlistScreen({Key? key}) : super(key: key);

  @override
  State<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends State<AddWishlistScreen> {
  late final TextEditingController bookNameController;
  late final TextEditingController authorNameController;
  WishlistRepository repository = WishlistRepository();

  @override
  void initState() {
    bookNameController = TextEditingController();
    authorNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    bookNameController.dispose();
    authorNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Wishlist'),
        backgroundColor: wishlistAppBarColor,
      ),
      body: CustomContainer(
        assetUrl: 'assets/images/white_brick.jpg',
        width: width,
        height: height,
        containerSize: 0.30,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: bookNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter a book name',
                ),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              TextField(
                controller: authorNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter a author name',
                ),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: () {
                    repository.addItem(
                      bookNameController.text,
                      authorNameController.text,
                    );
                    Navigator.of(context).pushNamed(WishlistScreen.id);
                  },
                  child: const Text(
                    'Add',
                    style: textButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
