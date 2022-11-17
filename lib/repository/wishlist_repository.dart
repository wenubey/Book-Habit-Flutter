// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:book_habits/model/wishlist.dart';
import 'package:uuid/uuid.dart';

class WishlistRepository {
  final BookRepository bookRepository = BookRepository();
  final Box<Wishlist> wishlistBox = Hive.box<Wishlist>(wishlistBoxName);
  List<Wishlist> wishlistList = [];
  final _random = Random();
  var uuid = const Uuid();

  void addItem(String bookName, String authorName) {
    var newId = uuid.v4();
    wishlistBox.put(
      newId,
      Wishlist(
        id: newId,
        bookName: bookName,
        bookAuthor: authorName,
      ),
    );
  }

  void editItem(Wishlist oldWishlist, String bookName, String authorName) {
    wishlistBox.delete(oldWishlist.id);
    wishlistBox.put(
      oldWishlist.id,
      Wishlist(
        id: oldWishlist.id,
        bookName: bookName,
        bookAuthor: authorName,
      ),
    );
  }

  void deleteItem(String id) {
    wishlistBox.delete(id);
  }

  List<Wishlist> getSortedList() {
    List<Wishlist> list = wishlistBox.values.toList();
    list.sort((a, b) => a.bookName.compareTo(b.bookName));
    return list;
  }

  void moveToBookList(Wishlist oldWishlist, String pageCount, String genre) {
    wishlistBox.delete(oldWishlist.id);
    bookRepository.addBook(
        oldWishlist.bookName, oldWishlist.bookAuthor, pageCount, genre);
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

  void pickRandomWishlit(String pageCount, String genre) {
    int random = 0 + _random.nextInt(wishlistBox.values.length - 0);
    wishlistList = wishlistBox.values.toList();
    Wishlist currentWishlist = wishlistList.elementAt(random);
    moveToBookList(currentWishlist, pageCount, genre);
  }
}
