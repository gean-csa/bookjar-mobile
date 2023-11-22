import 'package:bookjar_mobile/constants/colors.dart';
import 'package:bookjar_mobile/constants/texts_styles.dart';
import 'package:bookjar_mobile/mock/favorite_books.dart';
import 'package:bookjar_mobile/mock/user.dart';
import 'package:bookjar_mobile/models/book.dart';
import 'package:bookjar_mobile/presentation/widgets/book_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    if (isGuest == true) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        final textController = TextEditingController();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Digite seu nome de usuário:',
              style: subheader,
            ),
            content: TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Usuário'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    username = textController.text;
                  });
                  isGuest = false;
                },
                child: const Text(
                  "Enviar",
                  style: subheader,
                ),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookJar"),
        backgroundColor: primary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: title,
              ),
              const SizedBox(height: 4),
              if (favoriteBooks.isEmpty)
                Text("Não há livros favoritos", style: subheader)
              else
                Text("$favoritesLength livros favoritos", style: subheader),
              const SizedBox(height: 24),
              BookList(bookList: favoriteBooks),
            ],
          ),
        ),
      ),
    );
  }
}
