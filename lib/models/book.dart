import 'package:flutter/material.dart';

class Book {
  late String? code; // É o 'id' dentro da API do Google Books
  late String? title;
  late List<dynamic>? authors;
  late String? publisherName;

  Book({this.code, this.title, this.authors, this.publisherName});

  Book.fromJson(Map<String, dynamic> json) {
    code = json["id"];
    title = json["volumeInfo"]["title"];
    authors = json["volumeInfo"]["authors"];
    publisherName = json["volumeInfo"]["publisher"];
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'authors': authors,
        'publisherName': publisherName,
      };
}
