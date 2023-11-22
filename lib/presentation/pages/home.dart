import '../pages/page_teste.dart';
import '../widgets/book_list.dart';
import '../../constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bookjar_mobile/models/book.dart';
import 'package:bookjar_mobile/presentation/pages/profile_page.dart';
import 'dart:convert' as convert;

final apiUrl = Uri.https(
  'www.googleapis.com',
  '/books/v1/volumes',
  {
    'q': '{http}',
    'projection': 'lite',
  },
);

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response;
  @override
  void initState() {
    response = http.get(apiUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgray,
      appBar: AppBar(
        title: const Text("BookJar"),
        backgroundColor: primary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) =>
                        const ProfilePage())); 
              },
              icon: const Icon(Icons.account_circle),
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
          child: FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                late dynamic data = snapshot.data;
                if (data.statusCode != null && data.statusCode == 200) {
                  final jsonResponse = convert.jsonDecode(data.body);
                  List<Book> books = [];
                  for (var item in jsonResponse['items']) {
                    Book currentBook = Book.fromJson(item);
                    books.add(currentBook);
                  }
                  return BookList(bookList: books);
                } else {
                  return Center(
                    child:
                        Text("Request failed with status ${data.statusCode}"),
                  );
                }
              } else {
                return const Center(child: Text("Esperando dados..."));
              }
            },
          ),
        ),
      ),
    );
  }
}
