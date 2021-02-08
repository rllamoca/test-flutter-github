class Author{ //Modelo para poder hacer parse a los servicios de github
  String name;
  String email;
  DateTime date;

  Author({this.name, this.email, this.date});

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
      name: json['name'],
      email: json['email'],
      date: DateTime.tryParse(json['date'])
    );
  }
}