import 'package:book_habits/api/notification_api.dart';
import 'package:book_habits/model/wishlist.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/model/book.dart';
import 'package:book_habits/screens/add_wishlist_screen.dart';
import 'package:book_habits/screens/edit_book_page.dart';
import 'package:book_habits/screens/edit_wishlist_screen.dart';
import 'package:book_habits/screens/home_page.dart';
import 'package:book_habits/screens/statistics_screen.dart';
import 'package:book_habits/screens/wishlist_screen.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationApi.init();
  await Hive.initFlutter();
  Hive.registerAdapter<Book>(BookAdapter());
  Hive.registerAdapter<Wishlist>(WishlistAdapter());
  await Hive.openBox<Wishlist>(wishlistBoxName);
  await Hive.openBox<Book>(booksBoxName);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookRepository(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: newThemeData,
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id: (context) => const HomePage(),
        AddBookScreen.id: (context) => const AddBookScreen(),
        EditBookPage.id: (context) => const EditBookPage(),
        WishlistScreen.id: (context) => const WishlistScreen(),
        AddWishlistScreen.id: (context) => const AddWishlistScreen(),
        EditWishlistScreen.id: (context) => const EditWishlistScreen(),
        StatisticScreen.id: (context) => const StatisticScreen(),
      },
    );
  }
}
