import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/texts_styles.dart';
import '../../models/book.dart';
import '../pages/add_note_page.dart';
import '../../mock/favorite_books.dart';

// Enum com os valores possiveis selecionaveis em cada tile
enum _MenuValues {
  favorite,
  note,
}

// Classe que constroi um 'tile' (tijolo?) de livro com suas características príncipais.
// Extende a classe StatefulWidget pois o seu estado físico pode ser reconstruído durante a execução.
class BookTile extends StatefulWidget {
  // Instancia do livro deste 'tile'
  final Book book;

  const BookTile({super.key, required this.book});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  @override
  Widget build(BuildContext context) {
    // Separamos alguns atributos individualmente para verificar por nulos.
    String? authorName = widget.book.authors?[0];
    String title = widget.book.title!;
    String note = widget.book.note!;

    // Encontramos livros sem autores na API, esse foi o tratamento mais simples.
    Text subtitle;
    if (authorName != null) {
      if (note != null) {
        subtitle = Text("$authorName\n$note", style: subheader);
      } else {
        subtitle = Text("$authorName", style: subheader);
      }
    } else {
      subtitle = const Text("Não encontrado", style: warning);
    }

    // Retornando o 'Widget' e suas caracteristicas principal para o build.
    return ListTile(
      tileColor: bgwhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: primary),
      ),
      title: Text(title, style: header),
      subtitle: subtitle,
      isThreeLine: true,
      // Este é o menu ao lado de cada BookTile, com as opções de favoritar e adicionar anotação.
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
        // 'onSelected' chamado quando uma opção é selecionada
        onSelected: (value) {
          if (!favoriteBooks.contains(widget.book)) {
            favoriteBooks.add(widget.book);
          }
          switch (value) {
            // Nesse caso somente notifica o usuário da alteração em seu perfil.
            case _MenuValues.favorite:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("O livro foi adicionado ao seus favoritos!"),
                ),
              );
              break;
            // Nesse outro caso, faz 'push' para a tela de anotação.
            case _MenuValues.note:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => AddNotePage(book: widget.book)));
              break;
          }
        },
      ),
    );
  }
}
