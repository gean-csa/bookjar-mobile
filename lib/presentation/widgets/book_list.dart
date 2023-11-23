import '../../models/book.dart';
import '../widgets/book_tile.dart';
import 'package:flutter/material.dart';

// Classe que recebe e constroi a lista de 'BookTile's a partir de uma Lista de Books.
// Essa class extende o StatelessWidget pois não há mudança de estado após sua construção inicial.
class BookList extends StatelessWidget {
  final List<Book> bookList;
  const BookList({super.key, required this.bookList});

  @override
  Widget build(BuildContext context) {
    // Usamos o construtor 'separated' de ListView para ter total controle dos items e o que os separam.
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        Book currentBook = bookList[index];
        return BookTile(
          book: currentBook,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
