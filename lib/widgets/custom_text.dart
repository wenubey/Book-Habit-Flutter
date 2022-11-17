import 'package:book_habits/utils/book_args.dart';

import 'package:book_habits/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final BookArgument screenArgument;
  const CustomText({Key? key, required this.screenArgument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Name: ${screenArgument.book.title}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const CustomDivider(),
            Text(
              'Book\'s Author: ${screenArgument.book.author}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const CustomDivider(),
            Text(
              'Current Page: ${screenArgument.book.currentPage.toString()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const CustomDivider(),
            Text(
              'Total Page: ${screenArgument.book.pageCount.toString()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const CustomDivider(),
            Text(
              'Genre: ${screenArgument.book.genre}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'isFinished: ${screenArgument.book.isFinished.toString()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'isFav: ${screenArgument.book.isFavourite.toString()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
