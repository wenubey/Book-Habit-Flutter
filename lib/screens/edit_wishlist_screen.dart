import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_container_widget.dart';
import 'package:book_habits/widgets/edit_wishlist_fab.dart';
import 'package:flutter/material.dart';
import '../repository/wishlist_repository.dart';

class EditWishlistScreen extends StatefulWidget {
  static const id = 'edit_wishlist_screen';
  const EditWishlistScreen({Key? key}) : super(key: key);

  @override
  State<EditWishlistScreen> createState() => _EditWishlistScreenState();
}

class _EditWishlistScreenState extends State<EditWishlistScreen> {
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
    Wishlist oldWishlist =
        ModalRoute.of(context)!.settings.arguments as Wishlist;
    bookNameController.text = oldWishlist.bookName;
    authorNameController.text = oldWishlist.bookAuthor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Wishlist'),
        backgroundColor: wishlistAppBarColor,
      ),
      body: CustomContainer(
        assetUrl: 'images/white_brick.jpg',
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
                height: 10,
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          EditWishlistFAB(repository: repository, oldWishlist: oldWishlist),
    );
  }
}
