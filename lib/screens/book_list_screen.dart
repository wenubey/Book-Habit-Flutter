import 'package:book_habits/api/notification_api.dart';
import 'package:book_habits/model/book.dart';
import 'package:book_habits/repository/book_repository.dart';
import 'package:book_habits/utils/constants.dart';
import 'package:book_habits/widgets/custom_alert_dialog.dart';
import 'package:book_habits/widgets/custom_container_with_image.dart';
import 'package:book_habits/widgets/custom_listtile_object.dart';
import 'package:book_habits/widgets/custom_sort_widget.dart';
import 'package:book_habits/widgets/list_tile_star_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class BookListScreen extends StatefulWidget {
  static const String id = 'book_list_screen';
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
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
            actions: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(right: 20, left: 8),
                child: Text(
                  'Book Habits',
                  style: listTileTextStyle,
                ),
              )),
              ListTileStarButton(
                  onPressed: () {
                    setState(() {
                      isFavouriteFilterChecked = !isFavouriteFilterChecked;
                    });
                  },
                  isFavourite: isFavouriteFilterChecked),
              TextButton(
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if (newTime == null) return;
                    setState(() => time = newTime);
                    NotificationApi.showScheduledNotification(
                      hours: newTime.hour,
                      minutes: newTime.minute,
                    );
                  },
                  child: const Icon(
                    Icons.notifications,
                    color: beige,
                  )),
              CustomSortWidget(
                listOfTaps: listOfFunctions(),
                onPressed: () {
                  setState(() {
                    sortSelection = '';
                  });
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: () => setState(() =>
                    isHideFinishedBooksChecked = !isHideFinishedBooksChecked),
                child: isHideFinishedBooksChecked
                    ? Image.asset(
                        'assets/icon/show.png',
                        color: beige,
                        width: 25,
                        height: 25,
                      )
                    : Image.asset(
                        'assets/icon/hide.png',
                        color: beige,
                        width: 25,
                        height: 25,
                      ),
              )
            ],
          ),
          body: CustomContainerWithImage(
            assetUrl: 'assets/images/bricks.jpg',
            opacity: 1.0,
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
                          return CustomListTileObject(
                            currentBook: currentBook,
                            repository: repository,
                            index: index,
                            onPressedDelete: () {
                              setState(() {
                                repository.deleteBook(currentBook.id);
                              });
                              Navigator.pop(context);
                            },
                            onPressedFavourite: () {
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                              repository.editFavourite(
                                currentBook,
                                isFavourite,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  onPressed: () {
                    BookRepository().deleteAll();
                    Navigator.pop(context);
                  },
                  contentText: deleteAllConfirmationText,
                ),
              );
            },
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
