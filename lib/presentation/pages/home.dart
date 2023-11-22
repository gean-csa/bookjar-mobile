import '../widgets/book_list.dart';
import '../../constants/colors.dart';
import '../../models/book.dart';
import '../../presentation/pages/profile_page.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Aqui declaramos a URL da API do Google Books pois somente a Home realiza a request
final apiUrl = Uri.https(
  'www.googleapis.com',
  '/books/v1/volumes',
  {
    // É possível passar diversos parametros para a 'query' de pesquisa que se encontra da documentação da API
    // porém escolhemos um pesquisa simples e um tema aleatório por padrão.
    'q': '{animais}',
    'projection': 'lite',
  },
);

// Classe que defina a pagina inicial do app.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response;
  @override
  void initState() {
    // Fazemos 'get' dos livros assim que a página está inicializando.
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
                // Navegação para a página de perfil
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => const ProfilePage()));
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
          // Utilizamos o 'Widget' FutureBuilder para lidar com a construção da página enquanto são buscados os dados na API.
          // A linguagem Dart (base do Flutter), utiliza o tipo próprio chamado 'Future' para lidar com as "promises" desses
          // objetos assíncronos.
          child: FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                late dynamic data = snapshot.data;
                if (data.statusCode != null && data.statusCode == 200) {
                  // Com o sucesso do 'request', convertemos a String bruta para JSON.
                  final jsonResponse = convert.jsonDecode(data.body);
                  List<Book> books = [];
                  // E então instanciamos os vários objetos Books a partir do construtor JSON.
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
