import 'package:book_habits/model/book.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/screens/edit_book_page.dart';
import 'package:book_habits/utils/book_args.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_alert_dialog.dart';
import 'package:book_habits/widgets/custom_container_with_image.dart';
import 'package:book_habits/widgets/list_tile_star_button.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomListTileObject extends StatelessWidget {
  final BookRepository repository;
  final int index;
  final VoidCallback onPressedDelete;
  final VoidCallback onPressedFavourite;
  const CustomListTileObject({
    Key? key,
    required this.currentBook,
    required this.repository,
    required this.index,
    required this.onPressedDelete,
    required this.onPressedFavourite,
  }) : super(key: key);

  final Book currentBook;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    onPressed: onPressedDelete,
                    contentText: deleteConfirmationText,
                  ),
                );
              },
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              EditBookPage.id,
              arguments: BookArgument(book: currentBook, index: index),
            );
          },
          child: CustomContainerWithImage(
            assetUrl: 'assets/images/wood.jpg',
            opacity: 0.7,
            child: ListTile(
              leading: ListTileStarButton(
                isFavourite: currentBook.isFavourite,
                onPressed: () {},
              ),
              trailing: CircleProgressBar(
                foregroundColor: orange,
                backgroundColor: lightOrange,
                value: repository.calculatePercentage(currentBook),
                child: Center(
                  child: Text(
                    '${(repository.calculatePercentage(currentBook) * 100).toInt().toString()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                currentBook.title,
                style: listTileTextStyle,
              ),
              subtitle: Text(
                currentBook.author.toUpperCase(),
                style: listTileTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
