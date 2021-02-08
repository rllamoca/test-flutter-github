class Stat{  //Modelo para poder hacer parse a los servicios de github
  int total;
  int additions;
  int deletions;

  Stat({this.total, this.additions, this.deletions});

  factory Stat.fromJson(Map<String, dynamic> json){
    return Stat(
      total: json['total'],
      additions: json['additions'],
      deletions: json['deletions']
    );
  }
}