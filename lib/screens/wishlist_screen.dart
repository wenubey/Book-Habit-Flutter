import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/repository/wishlist_repository.dart';
import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/screens/add_wishlist_screen.dart';
import 'package:book_habits/screens/edit_wishlist_screen.dart';
import 'package:book_habits/screens/home_page.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/drawer_button.dart';
import 'package:book_habits/widgets/image_decorations.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WishlistScreen extends StatefulWidget {
  static const id = 'wishlist_screen';
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    Box<Wishlist> box = Hive.box<Wishlist>(wishlistBoxName);
    WishlistRepository repository = WishlistRepository();
    late Wishlist currentWish;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: wishlistAppBarColor,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ImageDecoration(
            assetUrl: 'assets/images/white_brick.jpg',
            opacity: 1,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AddWishlistScreen.id),
                    text: 'Add your book to wishlist',
                  ),
                  DrawerButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(HomePage.id),
                    text: 'Return book list',
                  ),
                  DrawerButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddBookScreen.id, arguments: currentWish);
                    },
                    text: 'Pick random book to read',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ImageDecoration(
        assetUrl: 'assets/images/white_brick.jpg',
        opacity: 1,
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                List<Wishlist> currentWishlist = repository.getSortedList();
                currentWish = currentWishlist.elementAt(index);
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(EditWishlistScreen.id,
                          arguments: currentWish);
                    },
                    child: ImageDecoration(
                      assetUrl: 'assets/images/wood.jpg',
                      opacity: 1,
                      child: ListTile(
                        title: Text(
                          currentWish.bookName,
                          style: listTileTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          currentWish.bookAuthor,
                          style: listTileTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
