import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/repository/wishlist_repository.dart';
import 'package:book_habits/screens/home_page.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_container_widget.dart';
import 'package:book_habits/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';

class AddBookScreen extends StatefulWidget {
  static const String id = '/add_book_screen';
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  late final TextEditingController titleController;
  late final TextEditingController authorController;
  late final TextEditingController pageCountController;
  final BookRepository repository = BookRepository();
  String selectedGenre = genreList.first;

  @override
  void initState() {
    titleController = TextEditingController();
    authorController = TextEditingController();
    pageCountController = TextEditingController();
    super.initState();
  }

  bool isArgNull(Wishlist? wishlist) {
    if (wishlist == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    pageCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Wishlist? oldWishlist =
        ModalRoute.of(context)?.settings.arguments as Wishlist?;

    if (oldWishlist != null) {
      titleController.text = oldWishlist.bookName;
      authorController.text = oldWishlist.bookAuthor;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: SafeArea(
        child: CustomContainer(
          assetUrl: 'assets/images/bricks.jpg',
          width: width,
          height: height,
          containerSize: 0.48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldList(
                controller1: titleController,
                controller2: authorController,
                controller3: pageCountController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select a genre',
                style: TextStyle(
                  color: warmBrown,
                ),
              ),
              const CustomDivider(),
              DropdownButton(
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
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value!;
                  });
                },
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (oldWishlist == null) {
                      repository.addBook(
                        titleController.text,
                        authorController.text,
                        pageCountController.text,
                        selectedGenre,
                      );
                    } else {
                      WishlistRepository().moveToBookList(
                        oldWishlist,
                        pageCountController.text,
                        selectedGenre,
                      );
                    }
                    Navigator.of(context).pushNamed(HomePage.id);
                  },
                  child: const Text(
                    'Save',
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
