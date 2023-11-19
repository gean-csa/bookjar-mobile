import 'package:bookjar_mobile/presentation/pages/page_teste.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

enum _MenuValues {
  favorite,
  note,
}

class BookTile extends StatelessWidget {
  final String title;
  final String? authorName;
  final String? note;

  const BookTile({super.key, required this.title, this.authorName, this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: bgwhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: primary),
      ),
      title: Text(title),
      subtitle: authorName != null
          ? note != null
              ? Text("$authorName\n$note")
              : Text("$authorName")
          : const Text("Não encontrado"),
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
          switch (value) {
            case _MenuValues.favorite:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) =>
                      const PageTeste())); //TODO: Implementar paginas
              break;
            case _MenuValues.note:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) =>
                      const PageTeste())); //TODO: Implementar paginas
          }
        },
      ),
    );
  }
}
