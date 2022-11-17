import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatefulWidget {
  final bool isHideFinishedBooksChecked;
  final Function(int) onselected;
  const CustomPopUpMenu({
    super.key,
    required this.isHideFinishedBooksChecked,
    required this.onselected,
  });

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(widget.isHideFinishedBooksChecked
              ? 'Show finished books'
              : 'Hide finished books'),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text('Add Book'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Go to wishlist'),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text('Statistics'),
        ),
        const PopupMenuItem(
          value: 4,
          child: Text('Delete All'),
        ),
      ],
      onSelected: widget.onselected,
    );
  }
}
