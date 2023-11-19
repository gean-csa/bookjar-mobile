import '../pages/page_teste.dart';
import '../widgets/book_list.dart';
import '../../constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
                        const PageTeste())); //TODO: Implementar paginas
              },
              icon: const Icon(Icons.menu),
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
                return BookList(data: snapshot.data);
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
