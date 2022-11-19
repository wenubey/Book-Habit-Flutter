import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_edit_wishlist_row.dart';
import 'package:book_habits/widgets/custom_input_container.dart';
import 'package:book_habits/widgets/custom_textfield.dart';
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
      body: CustomInputContainer(
        assetUrl: 'assets/images/white_brick.jpg',
        width: width,
        height: height,
        containerSize: 0.30,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField(
                controller: bookNameController,
                hintText: 'Enter a book name',
              ),
              CustomTextField(
                controller: authorNameController,
                hintText: 'Enter a author name',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditWishlistRow(
                repository: repository,
                oldWishlist: oldWishlist,
                bookNameController: bookNameController,
                authorNameController: authorNameController,
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
