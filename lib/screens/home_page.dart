import 'package:book_habits/screens/add_book_page.dart';
import 'package:book_habits/screens/book_list_screen.dart';
import 'package:book_habits/screens/statistics_screen.dart';
import 'package:book_habits/screens/wishlist_screen.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_screen';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = const [
    BookListScreen(),
    AddBookScreen(),
    WishlistScreen(),
    StatisticScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedIndex,
        destinations: [
          const NavigationDestination(
              icon: Icon(
                Icons.home,
                color: beige,
              ),
              label: 'Home'),
          const NavigationDestination(
              icon: Icon(
                Icons.add,
                color: beige,
              ),
              label: 'Add Book'),
          NavigationDestination(
              icon: Image.asset(
                'assets/icon/wishlist.png',
                height: 25,
                width: 25,
                color: beige,
              ),
              label: 'Wishlist'),
          NavigationDestination(
              icon: Image.asset(
                'assets/icon/pie-chart.png',
                height: 25,
                width: 25,
                color: beige,
              ),
              label: 'Statistics'),
        ],
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
      ),
    );
  }
}
