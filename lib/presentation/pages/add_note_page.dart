import '../../constants/colors.dart';
import '../../constants/texts_styles.dart';
import '../../models/book.dart';
import '../widgets/book_tile.dart';
import '../../mock/favorite_books.dart';
import 'package:flutter/material.dart';

// Define a classe da tela de anotações nos livros.
// Extende o 'StatefulWidget' pois seu estado é gerenciado durante a execução do app.
class AddNotePage extends StatefulWidget {
  final Book book;
  const AddNotePage({super.key, required this.book});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  // Declaramos o controlador do campo de texto antes mesmo da construção da página.
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
          // Definimos o campo para a anotação do livro com várias opções de customização.
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
              // Ao finalizar a anotação e clicar em salvar, o atributo é alterado
              // e o método setState() da pagina é chamado para atualizar visualmente o estado daquele BookTile.
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
