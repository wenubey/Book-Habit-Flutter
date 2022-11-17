import 'dart:developer';
import 'package:book_habits/api/notification_api.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/utils/book_args.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/screens/edit_book_page.dart';
import 'package:book_habits/widgets/custom_alert_dialog.dart';
import 'package:book_habits/widgets/custom_gesture_list.dart';
import 'package:book_habits/widgets/custom_pop_up_menu.dart';
import 'package:book_habits/widgets/image_decorations.dart';
import 'package:book_habits/widgets/list_tile_star_button.dart';
import 'package:book_habits/widgets/sort_screen_button.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../model/book.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_screen';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHideFinishedBooksChecked = false;
  bool isFavourite = false;
  bool isFavouriteFilterChecked = false;
  bool isFilterChecked = false;
  int selection = 0;
  String sortSelection = '';
  String filterSelection = '';
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookRepository>(
      builder: (context, repository, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Book Habits'),
            actions: [
              TextButton(
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if (newTime == null) return;
                    setState(() => time = newTime);
                    NotificationApi.showScheduledNotification(
                      title: 'ZAXD',
                      body: 'Burak bir gottur',
                      hours: newTime.hour,
                      minutes: newTime.minute,
                    );
                  },
                  child: const Icon(Icons.notifications)),
              ListTileStarButton(
                  onPressed: () {
                    setState(() {
                      isFavouriteFilterChecked = !isFavouriteFilterChecked;
                    });
                  },
                  isFavourite: isFavouriteFilterChecked),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Sort'),
                        content: Form(
                          child: CustomGestureList(
                            listOfTaps: listOfFunctions(),
                          ),
                        ),
                        actions: [
                          SortScreenButton(
                            onPressed: () {
                              setState(() {
                                sortSelection = '';
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.sort, color: Colors.white),
              ),
              CustomPopUpMenu(
                isHideFinishedBooksChecked: isHideFinishedBooksChecked,
                onselected: (value) {
                  if (value == 0) {
                    setState(() {
                      isHideFinishedBooksChecked = !isHideFinishedBooksChecked;
                    });
                    log('isHideFinishedBooksChecked: $isHideFinishedBooksChecked');
                  }
                  repository.menuChoose(
                      value, isHideFinishedBooksChecked, context);
                },
              )
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bricks.jpg'),
                fit: BoxFit.fitHeight,
                opacity: 1.0,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: genreList.length,
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: warmBrown,
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFilterChecked = !isFilterChecked;
                                filterSelection = genreList.elementAt(index);
                              });
                              log('isFilterChecked: $isFilterChecked');
                            },
                            child: Center(
                              child: Text(
                                genreList.elementAt(index),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: BookRepository.booksBox.listenable(),
                    builder: (context, box, child) {
                      return ListView.builder(
                        itemCount: repository
                            .sortAndFilter(
                              sortSelection,
                              isHideFinishedBooksChecked,
                              isFavouriteFilterChecked,
                              isFilterChecked,
                              filterSelection,
                            )
                            .length,
                        itemBuilder: (context, index) {
                          List<Book> list = repository.sortAndFilter(
                            sortSelection,
                            isHideFinishedBooksChecked,
                            isFavouriteFilterChecked,
                            isFilterChecked,
                            filterSelection,
                          );
                          Book currentBook = list.elementAt(index);
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
                                          repository: repository,
                                          index: index,
                                          onPressed: () {
                                            setState(() {
                                              log(currentBook.id);
                                              repository
                                                  .deleteBook(currentBook.id);
                                            });
                                            Navigator.pop(context);
                                          },
                                          contentText: deleteConfirmationText,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    EditBookPage.id,
                                    arguments: BookArgument(
                                        book: currentBook, index: index),
                                  );
                                  log(currentBook.isFavourite.toString());
                                },
                                child: ImageDecoration(
                                  assetUrl: 'images/wood.jpg',
                                  opacity: 0.7,
                                  child: ListTile(
                                    leading: ListTileStarButton(
                                      isFavourite: currentBook.isFavourite,
                                      onPressed: () {
                                        setState(() {
                                          isFavourite = !isFavourite;
                                        });
                                        repository.editFavourite(
                                          currentBook,
                                          isFavourite,
                                        );
                                      },
                                    ),
                                    trailing: CircleProgressBar(
                                      foregroundColor: orange,
                                      backgroundColor: lightOrange,
                                      value: repository
                                          .calculatePercentage(currentBook),
                                      child: Center(
                                        child: Text(
                                          '${(repository.calculatePercentage(currentBook) * 100).toInt().toString()}%',
                                          style: const TextStyle(
                                              color: Colors.white),
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
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Function()> listOfFunctions() {
    return [
      () {
        setState(() {
          sortSelection = 'title';
        });
        Navigator.pop(context);
      },
      () {
        setState(() {
          sortSelection = 'author';
        });
        Navigator.pop(context);
      },
      () {
        setState(() {
          sortSelection = 'currentPage';
        });
        Navigator.pop(context);
      },
      () {
        setState(() {
          sortSelection = 'isFinished';
        });
        Navigator.pop(context);
      },
      () {
        setState(() {
          sortSelection = 'genre';
        });
        Navigator.pop(context);
      },
    ];
  }
}
