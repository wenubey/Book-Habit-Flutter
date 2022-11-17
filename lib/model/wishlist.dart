import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'wishlist.g.dart';

const String wishlistBoxName = 'wishlist';
const Uuid uuid = Uuid();

@HiveType(typeId: 1)
class Wishlist {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String bookName;
  @HiveField(2)
  final String bookAuthor;

  Wishlist({
    required this.id,
    required this.bookName,
    required this.bookAuthor,
  });
}
