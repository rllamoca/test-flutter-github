import 'author.dart';

class Commit{ //Modelo para poder hacer parse a los servicios de github
  Author author;
  String message;
  String url;

  Commit({this.author, this.message, this.url});

  factory Commit.fromJson(Map<String, dynamic> json){
    return Commit(
      author: Author.fromJson(json['author']),
      message: json['message'],
      url: json['url']
    );
  }
}