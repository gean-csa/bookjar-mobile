import 'package:bookjar_mobile/presentation/pages/page_teste.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'package:bookjar_mobile/constants/texts_styles.dart';
import 'package:bookjar_mobile/models/book.dart';
import 'package:bookjar_mobile/presentation/pages/add_note_page.dart';
import 'package:bookjar_mobile/mock/favorite_books.dart';

enum _MenuValues {
  favorite,
  note,
}

class BookTile extends StatefulWidget {

  final Book book;

  const BookTile({super.key, required this.book});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  @override
  Widget build(BuildContext context) {
    String? authorName = widget.book.authors?[0];
    String title = widget.book.title!;
    String note = widget.book.note!;

    // Encontramos livros sem autores na API, esse foi o tratamento mais simples.
    Text subtitle = authorName != null
        ? note != null
            ? Text("$authorName\n$note", style: subheader)
            : Text("$authorName", style: subheader)
        : const Text(
            "Não encontrado",
            style: warning,
          );
          
    return ListTile(
      tileColor: bgwhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: primary),
      ),
      title: Text(title, style: header),
      subtitle: subtitle,
      isThreeLine: true,
      trailing: PopupMenuButton<_MenuValues>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: _MenuValues.favorite,
            child: Text("Marcar como favorito"),
          ),
          const PopupMenuItem(
            value: _MenuValues.note,
            child: Text("Adicionar Anotação"),
          ),
        ],
        onSelected: (value) {
          if (!favoriteBooks.contains(widget.book)) {
            favoriteBooks.add(widget.book);
          }
          switch (value) {
            case _MenuValues.favorite:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("O livro foi adicionado ao seus favoritos!"),
                ),
              );
              break;
            case _MenuValues.note:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) =>
                      AddNotePage(book: widget.book)));
              break;
          }
        },
      ),
    );
  }
}
