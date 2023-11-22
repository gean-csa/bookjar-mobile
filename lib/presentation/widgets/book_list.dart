import '../../models/book.dart';
import '../widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;



class BookList extends StatelessWidget {
  final List<Book>bookList;
  const BookList({super.key, required this.bookList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        Book currentBook = bookList[index];
        return BookTile(book: currentBook,);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
