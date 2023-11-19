import '../../models/book.dart';
import '../widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

List<Book> bookList = [];

class BookList extends StatelessWidget {
  final data;
  const BookList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(data.body);
      for (var item in jsonResponse['items']) {
        Book currentBook = Book.fromJson(item);
        bookList.add(currentBook);
      }
    } else {
      return Center(
        child: Text("Request failed with status ${data.statusCode}"),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        Book currentBook = bookList[index];
        return BookTile(
          title: currentBook.title as String,
          authorName: currentBook.authors?[0],
          note: "ASDASDASD", // TODO: Implementar adição de comentario
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
