import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'book.g.dart';

const String booksBoxName = 'books';
const Uuid uuid = Uuid();

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final int pageCount;
  @HiveField(4)
  final int currentPage;
  @HiveField(5)
  final bool isFinished;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String genre;
  @HiveField(8)
  final String readedAt;
  @HiveField(9)
  final bool isFavourite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.pageCount,
    required this.currentPage,
    required this.isFinished,
    required this.createdAt,
    required this.genre,
    required this.readedAt,
    required this.isFavourite,
  });
}
