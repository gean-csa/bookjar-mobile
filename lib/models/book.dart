// Classe modelo para a criação das instâncias de Book pelo aplicativo
class Book {
  late String? code; // É o 'id' dentro da API do Google Books
  late String? title;
  late List<dynamic>? authors;
  late String? publisherName;
  late String? note = "";

  Book({this.code, this.title, this.authors, this.publisherName});

// Construtor baseado em objeto Json (para converter os dados da busca à API do Google Books)
  Book.fromJson(Map<String, dynamic> json) {
    code = json["id"];
    title = json["volumeInfo"]["title"];
    authors = json["volumeInfo"]["authors"];
    publisherName = json["volumeInfo"]["publisher"];
  }

// Método para converter a instancia em um objeto Json
  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'authors': authors,
        'publisherName': publisherName,
      };
}
