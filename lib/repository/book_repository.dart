import 'package:book_habits/model/book.dart';
import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/screens/statistics_screen.dart';
import 'package:book_habits/screens/wishlist_screen.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BookRepository extends ChangeNotifier {
  static Box<Book> booksBox = Hive.box<Book>(booksBoxName);
  var uuid = const Uuid();
  final DateFormat formattedDate = DateFormat('dd/MM/yyyy');
  List<Book> list = [];
  void editCurrentPage(Book oldBook, int currentPage) {
    if (oldBook.pageCount == currentPage) {
      booksBox.delete(oldBook.id);
      booksBox.put(
        oldBook.id,
        Book(
          id: oldBook.id,
          title: oldBook.title,
          author: oldBook.author,
          pageCount: oldBook.pageCount,
          currentPage: currentPage,
          isFinished: true,
          createdAt: oldBook.createdAt,
          genre: oldBook.genre,
          readedAt: formattedDate.format(DateTime.now()),
          isFavourite: oldBook.isFavourite,
        ),
      );
    } else {
      booksBox.delete(oldBook.id);
      booksBox.put(
        oldBook.id,
        Book(
          id: oldBook.id,
          title: oldBook.title,
          author: oldBook.author,
          pageCount: oldBook.pageCount,
          currentPage: currentPage,
          isFinished: false,
          createdAt: oldBook.createdAt,
          genre: oldBook.genre,
          readedAt: '',
          isFavourite: oldBook.isFavourite,
        ),
      );
    }
  }

  double calculatePercentage(Book book) {
    return ((book.currentPage * 100 / book.pageCount) / 100);
  }

  void deleteBook(String id) {
    booksBox.delete(id);
  }

  void addBook(String title, String author, String pageCount, String genre) {
    var newId = uuid.v4();
    booksBox.put(
      newId,
      Book(
        id: newId,
        title: title,
        author: author,
        pageCount: int.parse(pageCount),
        currentPage: 0,
        isFinished: false,
        createdAt: formattedDate.format(DateTime.now()),
        genre: genre,
        readedAt: 'Not yet finished',
        isFavourite: false,
      ),
    );
  }

  int getBookCount() {
    return booksBox.values.length;
  }

  int getTotalPage() {
    int totalPage = 0;
    for (Book book in booksBox.values) {
      totalPage += book.currentPage;
    }
    return totalPage;
  }

  String getFirstCreationDate() {
    String returnedString = '';
    list = booksBox.values.toList();
    if (list.isEmpty) {
      returnedString = '00/00/0000';
    } else {
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      returnedString = list.first.createdAt;
    }
    return returnedString;
  }

  List<Book> sortAndFilter(
    String sortElement,
    bool isFinishedBooksChecked,
    bool isFavouriteItemsChecked,
    bool isFilterChecked,
    String filterElement,
  ) {
    if (isFavouriteItemsChecked == true &&
        isFilterChecked == true &&
        isFinishedBooksChecked == true) {
      list = booksBox.values
          .where((book) =>
              book.isFinished == false &&
              book.genre == filterElement &&
              book.isFavourite == true)
          .toList();
    } else if (isFinishedBooksChecked == true && isFilterChecked == true) {
      list = booksBox.values
          .where(
              (book) => book.isFinished == false && book.genre == filterElement)
          .toList();
    } else if (isFavouriteItemsChecked == true && isFilterChecked == true) {
      list = booksBox.values
          .where(
              (book) => book.genre == filterElement && book.isFavourite == true)
          .toList();
    } else if (isFavouriteItemsChecked == true &&
        isFinishedBooksChecked == true) {
      list = booksBox.values
          .where((book) => book.isFavourite == true && book.isFinished == false)
          .toList();
    } else if (isFinishedBooksChecked == true) {
      list = booksBox.values.where((book) => book.isFinished == false).toList();
    } else if (isFilterChecked == true) {
      list =
          booksBox.values.where((book) => book.genre == filterElement).toList();
    } else if (isFavouriteItemsChecked == true) {
      list = booksBox.values.where((book) => book.isFavourite == true).toList();
    } else {
      list = booksBox.values.toList();
    }
    return sortItems(sortElement);
  }

  List<Book> sortItems(String sortElement) {
    switch (sortElement) {
      case 'title':
        list.sort((a, b) => a.title.compareTo(b.title));
        return list;
      case 'author':
        list.sort((a, b) => a.author.compareTo(b.author));
        return list;
      case 'currentPage':
        list.sort((a, b) => a.currentPage.compareTo(b.currentPage));
        return list;
      case 'isFinished':
        list.sort((a, b) => b.isFinished.toString().compareTo(a.toString()));
        return list;
      case 'genre':
        list.sort((a, b) => a.genre.compareTo(b.genre));
        return list;
      case 'createdAt':
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return list;
      default:
        return list;
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String genre in genreList) {
      var newItem = DropdownMenuItem(
        value: genre,
        child: Text(genre),
      );

      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  double _counterAct = 0;
  double _counterCla = 0;
  double _counterCom = 0;
  double _counterDet = 0;
  double _counterFan = 0;
  double _counterHor = 0;
  double _counterRom = 0;
  double _counterSci = 0;
  double _counterSho = 0;
  double _counterSus = 0;
  double _counterBio = 0;
  double _counterCoo = 0;
  double _counterPoe = 0;
  Map<String, double> getChartInfo() {
    setCounters();
    Map<String, double> map = {
      'Action and Adventure': _counterAct,
      'Classics': _counterCla,
      'Comic Book': _counterCom,
      'Detective and Mystery': _counterDet,
      'Fantasy': _counterFan,
      'Horror': _counterHor,
      'Romance': _counterRom,
      'Science Fiction (Sci-Fi)': _counterSci,
      'Short Stories': _counterSho,
      'Suspense and Thrillers': _counterSus,
      'Biographies and Autobiographies': _counterBio,
      'CookBooks': _counterCoo,
      'Poetry': _counterPoe,
    };

    return map;
  }

  void setCounters() {
    List<Book> bookList = booksBox.values.toList();
    for (Book book in bookList) {
      if (book.genre.contains('Action and Adventure')) {
        _counterAct++;
      } else if (book.genre.contains('Classics')) {
        _counterCla++;
      } else if (book.genre.contains('Comic Book')) {
        _counterCom++;
      } else if (book.genre.contains('Detective and Mystery')) {
        _counterDet++;
      } else if (book.genre.contains('Fantasy')) {
        _counterFan++;
      } else if (book.genre.contains('Horror')) {
        _counterHor++;
      } else if (book.genre.contains('Romance')) {
        _counterRom++;
      } else if (book.genre.contains('Science Fiction (Sci-Fi)')) {
        _counterSci++;
      } else if (book.genre.contains('Short Stories')) {
        _counterSho++;
      } else if (book.genre.contains('Suspense and Thrillers')) {
        _counterSus++;
      } else if (book.genre.contains('Biographies and Autobiographies')) {
        _counterBio++;
      } else if (book.genre.contains('CookBooks')) {
        _counterCoo++;
      } else if (book.genre.contains('Poetry')) {
        _counterPoe++;
      }
    }
  }

  void deleteAll() {
    booksBox.clear();
  }

  void showSnackBar(String content, BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: Text(content),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void menuChoose(int value, bool isFilterChecked, BuildContext context) {
    if (value == 1) {
      Navigator.of(context).pushNamed(AddBookScreen.id);
    } else if (value == 2) {
      Navigator.of(context).pushNamed(WishlistScreen.id);
    } else if (value == 3) {
      if (booksBox.values.isEmpty) {
        showSnackBar('You don\'t have any books.', context);
      } else {
        Navigator.of(context).pushNamed(StatisticScreen.id);
      }
    } else if (value == 4) {
      deleteAll();
    }
  }

  void editFavourite(Book oldBook, bool isFavouriteChecked) {
    booksBox.delete(oldBook.id);
    booksBox.put(
      oldBook.id,
      Book(
        id: oldBook.id,
        title: oldBook.title,
        author: oldBook.author,
        pageCount: oldBook.pageCount,
        currentPage: oldBook.currentPage,
        isFinished: oldBook.isFinished,
        createdAt: oldBook.createdAt,
        genre: oldBook.genre,
        readedAt: oldBook.readedAt,
        isFavourite: isFavouriteChecked,
      ),
    );
  }
}
