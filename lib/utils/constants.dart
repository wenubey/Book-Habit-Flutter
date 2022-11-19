import 'package:flutter/material.dart';

const String deleteConfirmationText =
    'Are you sure you want to delete this book because you will not be able to undo this action?';
const String deleteAllConfirmationText =
    'Are you sure you want to delete these book because you will not be able to undo this action?';

const String isFinishedConfirmationText =
    'Are you sure you finished the book because you will not be able to undo this action?';

const String deleteConfirmationWishText =
    'Are you sure want to delete this wish book because you will not be able to undo this action?';

const List<String> genreList = [
  'Action and Adventure',
  'Classics',
  'Comic Book',
  'Detective and Mystery',
  'Fantasy',
  'Horror',
  'Romance',
  'Science Fiction (Sci-Fi)',
  'Short Stories',
  'Suspense and Thrillers',
  'Biographies and Autobiographies',
  'CookBooks',
  'Poetry',
];

const customBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
  boxShadow: [
    BoxShadow(
      blurRadius: 7,
      spreadRadius: 7,
      color: paperColor,
    ),
  ],
  color: paperColor,
);

const customBorderTextField = UnderlineInputBorder(
  borderSide: BorderSide(color: warmBrown),
);

const whiteGrey = Color(0XFFE6E3E1);
const beige = Color(0XFFD1C8B8);
const lightBrown = Color(0XFFBAA388);
const brown = Color(0XFF95775A);
const warmBrown = Color.fromARGB(255, 156, 103, 53);
const orange = Color(0XFFFF5722);
const lightOrange = Color(0XFFFF9800);
const paperColor = Color(0XFFE9BC67);
const shadowColor = Color(0XFF2B2B2B);
const brickOrange = Color(0XFFA74A26);
const parliamentBlue = Color(0XFF003366);
const wishlistAppBarColor = Color(0XFF717575);
const goldColor = Color(0XFFFFD700);
List<Color> colorList = [
  const Color(0XFF8F00FF),
  const Color(0XFF4B0082),
  const Color(0XFF00FFFF),
  const Color(0XFF003366),
  const Color(0XFFADD8E6),
  const Color(0XFFBFEF45),
  const Color(0XFF3CB44B),
  const Color(0XFFFFE119),
  const Color(0XFF808000),
  const Color(0XFFFABED4),
  const Color(0XFFF58231),
  const Color(0XFF000075),
  const Color(0XFFE6194B),
];

const textButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

const listTileTextStyle = TextStyle(
  letterSpacing: 1.5,
  color: whiteGrey,
  fontFamily: 'Merienda',
  fontWeight: FontWeight.w900,
);

final newThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    color: brickOrange,
  ),
  primaryIconTheme: const IconThemeData(
    color: beige,
  ),
  timePickerTheme: TimePickerThemeData(
    dialHandColor: Colors.blueGrey,
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? paperColor : Colors.black),
    dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? paperColor : Colors.black),
    dialTextColor: parliamentBlue,
    dayPeriodColor: warmBrown,
    hourMinuteColor: warmBrown,
    backgroundColor: beige,
    dialBackgroundColor: paperColor,
  ),
  checkboxTheme:
      const CheckboxThemeData(fillColor: MaterialStatePropertyAll(beige)),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: warmBrown,
    labelTextStyle: MaterialStateProperty.all(
      listTileTextStyle,
    ),
    backgroundColor: brickOrange,
  ),
  hintColor: warmBrown,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(brickOrange),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: warmBrown,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Merienda',
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Merienda',
    ),
  ),
);
