import 'package:bookjar_mobile/constants/colors.dart';
import 'package:bookjar_mobile/constants/texts_styles.dart';
import 'package:bookjar_mobile/models/book.dart';
import 'package:bookjar_mobile/presentation/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:bookjar_mobile/mock/favorite_books.dart';

class AddNotePage extends StatefulWidget {
  final Book book;
  const AddNotePage({super.key, required this.book});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgray,
      appBar: AppBar(
        title: const Text("BookJar"),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        child: Column(children: [
          const Text("Escreva sua anotação sobre o livro:", style: title),
          const SizedBox(height: 16),
          BookTile(book: widget.book),
          const SizedBox(height: 24),
          TextField(
            controller: textController,
            expands: true,
            minLines: null,
            maxLines: null,
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxHeight: 113),
              fillColor: lightprimary,
              filled: true,
              hintText: "O livro é...",
              hintStyle: subheader,
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            style: const ButtonStyle(
              textStyle: MaterialStatePropertyAll(bttnlabel),
              backgroundColor: MaterialStatePropertyAll(primary),
            ),
            onPressed: () {
              widget.book.note = textController.text;
              setState(() {});
              if (!favoriteBooks.contains(widget.book)) {
                favoriteBooks.add(widget.book);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Anotação feita com sucesso! O livro foi adicionado ao seu perfil..."),
                ),
              );
            },
            child: const Text("Salvar Anotação"),
          ),
        ]),
      ),
    );
  }
}
